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
      
    @listings = query params[:group], tags: @tags
    @artist   = @listings[0][:artist]

    if params[:group] == 'collection'
      (request.path =~ /collection/ && @group = 'artist') || @group = 'exhibit'

      if @listings.count > 0 
        @description = @listings[0][:artist_description] if @group == 'artist'

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