class HomeController < ApplicationController
  def index
    cache_for 60

    @listings = query :home
  end
end
