class ListingController < ApplicationController
  def index
  
    # get listing
    @listing = image(params[:slug])[0]
    @artist  = params[:artist]
  end
end
