class ListingController < ApplicationController
  def index
  
    search = { title_slug:  params[:slug]   }    
    search = { artist_slug: params[:artist_slug] } if params[:artist_slug]

    # get listing
    @listing = Statement.listing( search )[0]

    # get associated art by artist, if artist slug is available
    if ( slug = params[:artist_slug]   ) || 
       ( slug = @listing[:artist_slug] )

      @listings  = Statement.collection tags: [ slug ]
      @slug      = params[:slug]
      @artist    = params[:artist]

    # otherwise we try to match by other tags other than
    # slug
    else
      @listings = Statement.collection tags: @listing[:tags]

    end
  
  end
end
