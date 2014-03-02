class ApplicationController < ActionController::Base
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected 

    def query name, params
      # create es client
      client = Elasticsearch::Client.new

      # parse statement file and return client
      # result
      erb = ERB.new(
        file = "#{ENV['RAILS_ROOT']}/db/elasticsearch/statements/" +
               "#{name}.json.erb"
      )

      # finally return
      client.search index: 'callowayart', 
                    body:  erb.result OpenStruct.new(params).instance_eval { binding }
    end

end
