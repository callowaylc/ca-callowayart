class ApplicationController < ActionController::Base
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected 

    def query name, params
      # create es client
      client = Elasticsearch::Client.new
      erb    = ERB.new(
        content = File.read(
          "#{ENV['RAILS_ROOT']}/db/elasticsearch/statements/" +
          "#{name}.json.erb"
        )
      )

      # parse and return valid statement and pass to 
      # elasticsearch client
      statement = erb.result OpenStruct.new(params).instance_eval { 
        binding 
      }
      result    = client.search index: 'callowayart', 
                                body:  statement


      # now massage result set into a simpler data structure
      data = [ ]


      # if aggregations have been returned, we are returning
      # a grouped result set
      if result['aggregations'].nil?
        result['hits']['hits'].each do | hash |
          bucket = hash['_source']

          data << {
            title: bucket['title'],
            description: bucket['description'],
            image: bucket['uri'],
            thumb: bucket['thumb'],
            artist: bucket['artist'] 
          }
          data[:exhibit] = bucket['exhibit'] unless bucket['exhibit'].nil?
        end

      else

        result['aggregations'][name]['buckets'].each do | bucket |
          data << {
            title:  bucket['key'],
            count:  bucket['doc_count'],
            image:  bucket['uri']['buckets'][0]['key'],
            thumb:  bucket['thumb']['buckets'][0]['key'],
            artist: bucket['artist']['buckets'][0]['key'],
            description: bucket['key']
          }
        end
      end

      data
    end

end
