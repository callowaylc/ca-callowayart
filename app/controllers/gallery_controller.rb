class GalleryController < ApplicationController
  LIMIT = 30

  def index
    # determine view params
  	@page  = params[:page]
  	
  	if params[:group].present?
  		@group = params[:group]
  		@terms = terms [ @group ]

  	end

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
  	# group by 

  end
end