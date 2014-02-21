class GalleryController < ApplicationController
  LIMIT = 30

  def index
    # determine view params
  	@page  = params[:page]
  	
  	# determine if resource specific page
  	# or if tags have been passed directly
  	if params[:tags].present?
	  	@tags = params[:tags]
	    @tags = @tags[1..@tags.length].split '/'

	  else
	  	@tags = [ ]
	  	@tags << params[:resource] if params[:resource].present?
	  	@tags << params[:slug]     if params[:slug ].present? 

	  end

    # get listings
    @listings = images @tags
  	
  	# if group is available, we will need to 
  	# group by um.. group
    if params[:group].present?
      @group = params[:group]
      @terms = terms [ @group ]
      groups = [ ]

      @terms.each do | term |
        @listings = @listings.collect do | listing |
          listing[:grouped].nil?
        end

        @listings.each do | listing |
          if (listing.tags.include? term)
            listing[:grouped]     = true
            groups[term]          = listing
            
            groups[term]['count'] ||= 0
            groups[term]['count'] += 1
        end
      end

      # collect any uncategorized content

      unless @listings.empty?
        groups['uncategorized']          = @listings.first
        groups['uncategorized']['count'] = @listings.count
      end

      @listings = groups

    end    


  end
end