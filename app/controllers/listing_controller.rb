class ListingController < ApplicationController
  def index
  
    params[:artist] = nil if params[:artist] == 'na'
    
    # get listing
    @listing = ( query 'listing',  
      artist_slug: params[:artist],
      title_slug:  params[:slug]
    )[0]


    # get associated art from the artist
    @listings = query :collection, tags: [ params[:artist] ]
    @slug     = params[:slug]
    @artist   = params[:artist]
  
  end
end
