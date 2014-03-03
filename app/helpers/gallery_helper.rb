module GalleryHelper

	def uri_for listing

    # somehow still listings with nil artist
    # setting to anonymous if the case
    listing[:artist] ||= 'na'

		# get current path and uses slugified
    # caption property to build new resource
    begin 
      unless listing[:count].nil?
  		  (request.path + '/' + slugify(listing[:title])).gsub 'gallery', 'collection'

      else
        '/listing'                + '/' + 
        slugify(listing[:artist]) + '/' + 
        slugify(listing[:title])
      end

    rescue
      
    end
	end

	def description_forr listing
    listing[:description].split("\n")[0..2].join('<br />')
	end

  protected 

    def slugify string
      string.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end

end