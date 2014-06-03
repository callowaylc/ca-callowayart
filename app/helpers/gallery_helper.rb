module GalleryHelper

	def uri_for listing


		# get current path and uses slugified
    # caption property to build new resource
    begin 
      unless listing[:count].nil?

        if request.path =~ /exhibit/
          request.path + '/' + slugify( listing[:title] )

        else
  		    request.path.gsub( 'gallery', 'collection' ) + 
          '/' + 
          slugify( listing[:artist] )

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
                                 listing[:description]
  end

end
