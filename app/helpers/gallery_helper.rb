module GalleryHelper

	def uri_for listing


		# get current path and uses slugified
    # caption property to build new resource
    begin 
      unless listing[:count].nil?

        # depending on resource path, return either 
        # artist slug or exhibit slug
        if request.path =~ /exhibit/
          request.path.sub( /\/(past|current|upcoming)/, '' ) + '/' + 
          listing[:exhibit_slug]
        else
          request.path.sub( 'gallery', 'collection' ) + '/' + 
          listing[:artist_slug]
        end

        


      else
        '/listing'                + '/' + 
        slugify(listing[:artist]) + '/' + 
        slugify(listing[:title])
      end

    rescue
      
    end
	end

  def description_forr listing
    request.path =~ /gallery/ && listing[:artist] ||
                                 listing[:description].gsub( /\n/, '<br />' )
  end

end
