class ListingController < ApplicationController
  def index
  
    # get listing
    @listing = image(params[:slug])[0]

  end
end
