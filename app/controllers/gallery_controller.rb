class GalleryController < ApplicationController
  layout 'gallery'
  include ApplicationHelper

  def index
    # retrieve upcoming exhibits
    @listings = sort Statement.groups_gallery( tags: tags )

    # if listings falls between 0 and MAX number
    if @listings.count.between?( 0, 5 )
      @facets = @listings.map do | listing |
        {
          slug:  listing[:slug],
          title: listing[:title].gsub('-', ' '),
          thumb: listing[:thumb],
          count: listing[:doc_count]
        }
      end

      @listings = Statement.collection( tags: tags )
    end

    # retrieve artist and description if there are less than
    if artist_collection?( @listings )
      @artist      = @listings[0][:artist]
      @description = @listings[0][:artist_description] 
    end


  end

  def design
  end

  private 

    def sort(listings)
      listings.sort_by do | listing |
        listing[:title].split( '-' )[-1]
      end
    end

    def artist_collection?(listings)
      @is_a_collection ||= begin
        uniques = listings.uniq { | record | record[:artist] }
        uniques.length == 1
      end
    end

end