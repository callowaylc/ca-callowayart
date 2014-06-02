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
    description = [ ]
 
    listing[:description].split("\n").each do | listing |
      #begin
        if listing !~ /\:/ ||
           (listing =~ /\:/ && listing.split(':').count  > 1) 
         
          description << listing.strip 
        end
      #rescue Exception => ignore
      #end

    end

    description.join '<br />'
  end

end
