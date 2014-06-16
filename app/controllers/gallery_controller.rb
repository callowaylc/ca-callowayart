class GalleryController < ApplicationController
  layout 'gallery'

  def index
    # retrieve upcoming exhibits
    @listings = sort Statement.groups_gallery( tags: tags )

    # retrieve artist and description if there are less than
    if artist_collection?( @listings )
      @artist      = @listings[0][:artist]
      @description = @listings[0][:artist_description] 
    end

    # if listings falls underneath threshold of 5 items
    # TODO: there is a better way to do this that is eluding
    # me at the moment
    if @listings.length < 5

      unless artist_collection?( @listings )
        @facets = @listings.map do | listing |
          {
            slug:  listing[:slug],
            title: listing[:title].gsub('-', ' '),
            thumb: listing[:thumb]
          }
        end
      end
      @listings = Statement.collection tags: tags
  
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