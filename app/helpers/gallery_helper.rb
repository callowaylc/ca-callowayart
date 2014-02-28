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

	def description_forr listing
    listing['description'].split("\n")[0..2].join('<br />')
	end

  protected 

    def slugify string
      #string.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
      string.downcase.strip.gsub(' ', '-')
    end

end