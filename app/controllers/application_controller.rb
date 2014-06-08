class ApplicationController < ActionController::Base
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # TODO: this isn't really needed for callowayart
  protect_from_forgery with: :exception
  helper_method :tags

  # Add application helper methods to controller context
  include ApplicationHelper

  protected 
    def dont_cache
      cache_for 0
    end

    def cache_for seconds
      response.headers['X-Varnish-TTL'] = seconds.to_s + 's'
    end


end
