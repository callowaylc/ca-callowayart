class GalleryController < ApplicationController
  LIMIT = 30

  def index
    # determine view params
  	@page = params[:page]

  	@tags = params[:tags]
    @tags = @tags[1..@tags.length].split '/'

    raise @tags.to_s

    # get listings
    @listings = images @tags
  	

  end
end
