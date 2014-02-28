class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected 

  	def images(tags)
      response = client.get '/api/image', { tags: tags }
      JSON.parse response.body
  	end

    def image(slug)
      response = client.get '/api/image', { slug: slug }

      JSON.parse response.body
    end

    def terms(terms)
      response = client.get '/api/term', { terms: terms }

      JSON.parse response.body
    end

  private
    def client 
      Faraday.new(
        :url => 'http://cms.callowayart.com'
      
      ) do | faraday |
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter
      end      
    end

end
