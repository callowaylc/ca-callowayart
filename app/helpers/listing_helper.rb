module ListingHelper

	def description_for listing
    	listing['description'].gsub /\n/, '<br />'
	end

end