module GalleryHelper

	def uri_for listing

    return request.path + '/' + listing[:slug]
    
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

  def description_for listing
    if listing[:description]
      # remove first line of description if same as title
      # TODO: this is entirely a hack and should be fixed at
      # index time
      description = listing[:description].split( /\n/)
      if description[0].downcase.strip == listing[:title].downcase.strip
        description = description[1..-1]
      end

      description.join '<br />'
    end
                                     
  end

end
