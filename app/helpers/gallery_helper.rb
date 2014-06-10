module GalleryHelper

	def uri_for listing


		# get current path and uses slugified
    # caption property to build new resource
    begin 
      unless listing[:count].nil?

        # depending on resource path, return either 
        # artist slug or exhibit slug
        slug = if request.path =~ /exhibit/
          listing[:artist_slug]
        else
          listing[:exhibit_slug]
        end

        request.path.sub( 'gallery', 'collection' ) + '/' + slug


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
