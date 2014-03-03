class ListingController < ApplicationController
  def index
  
    # get listing
    @listing = (query 'listing', {
    	artist_slug: params['artist'],
      title_slug:  params['slug']
    })[0]
  end
end
