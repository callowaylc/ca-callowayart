class GalleryController < ApplicationController
  layout 'gallery'

  def index
    params[:group] = 'collection' if params[:exhibit].present?

    # assign view params
  	@page  = params[:page]
    @tags  = [ ]

    if tags.count > 0
      @tags = tags 
    end


    if request.path =~ /^\/search/ && params[:q].present?
      params[:group] = 'search'
      @tags          = [ params[:q] ]
    end
      
    @listings = Statement.query( params[:group], tags: @tags )

    if @listings.count > 0

      if params[:group] == 'collection'
        (request.path =~ /collection/ && @group = 'artist') || @group = 'exhibit'
        
        @title = @listings[0][:artist] if @group == 'artist'
        @title = @listings[0][:exhibit] if @group == 'exhibit'

        if @listings.count > 0 
          @description = @listings[0][:artist_description]  if @group == 'artist'
          @description = @listings[0][:exhibit_description] if @group == 'exhibit'
        end
      end
    end

    render
  end

  def design
  end


end
