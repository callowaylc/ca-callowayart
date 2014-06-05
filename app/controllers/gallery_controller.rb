class GalleryController < ApplicationController
  LIMIT = 30

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
      
    @listings = query( params[:group], tags: @tags )


    if params[:group] == 'collection' 
      @listings += query( 'collection_sold', tags: @tags )
    end
    
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

  end

  protected

    def tags
      # basically moving the chaos that is the current route
      # sytem into hte idea of tags; all of this needs to be
      # replaced
      if params[:tags].present?
        tags = params[:tags]
        tags = tags[1..tags.length].split '/'

      else
        tags = [ ]
        tags << params[:resource] if params[:resource].present?
        tags << params[:slug]     if params[:slug ].present? 

      end

      tags << params[:exhibit] if params[:exhibit].present?
      tags
    end

end
