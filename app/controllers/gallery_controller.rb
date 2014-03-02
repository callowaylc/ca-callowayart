class GalleryController < ApplicationController
  LIMIT = 30

  def index
    # assign view params
  	@page  = params[:page]
    @tags  = tags

    params[:group] = 'collection' if params[:exhibit].present?

    @listings = query params[:group], { tags: @tags }
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