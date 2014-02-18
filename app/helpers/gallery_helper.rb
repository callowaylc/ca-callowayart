module GalleryHelper

	def uri_for listing

		# if group is present, then we are defining a resource
		# 
		unless @group.nil?
			

		else
			slugify listing

		end

	end

	def slugify listing
		listing.caption.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')

	end

	def description_for listing
		listing['description'].gsub /\n/, '<br />' 

	end

	def terms
		super params[:group]

	end

end
