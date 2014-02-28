module GalleryHelper

	def uri_for listing

		# get current path and uses slugified
    # caption property to build new resource
    unless listing['count'].nil?
		  request.path + '/' + slugify(listing['title'])

    else
      '/listing'                 + '/' + 
      slugify(listing['artist']) + '/' + 
      slugify(listing['title'])
    end
	end

	def description_for listing
    listing['description'].gsub /\n/, '<br />'
	end

  protected 

    def slugify string
      #string.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
      string.downcase.strip.gsub(' ', '-')
    end

end