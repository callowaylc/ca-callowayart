class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected 

  	def images(tags)
      client = Faraday.new(
        :url => 'http://cms.callowayart.stage'
      
      ) do | faraday |
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter
      end

      response = client.get '/api/image', { tags: tags }


      JSON.parse response.body
  	end
end
