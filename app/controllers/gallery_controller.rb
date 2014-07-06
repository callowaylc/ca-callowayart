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

    # otherwise we are showing aggregates 
    else

      # aggregates are simply tags - get a list of 
      # all hidden tags and remove from list
      hidden = Statement.hidden_tags( tags: @listings.map { | listing | 
        listing[:slug]
      })

      raise hidden.to_s

    end

    # determine if "artist collection" and if the case
    # retrieve name and description, if available
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