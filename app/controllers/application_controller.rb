class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected 

  	def images(tags)
      response = RestClient.get 
        'http://cms.callowayart.stage/api/image', params: { 
          tags: tags 
        }

      JSON.parse response
  	end
end
