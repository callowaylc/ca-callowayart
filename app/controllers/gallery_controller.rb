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

    @tags << params[:exhibit] if params[:exhibit].present?

    # get listings
    @listings = images @tags

  	# if group is available, we will need to 
  	# group by um.. group
    if params[:group].present?

      # TODO: this is a total hack because I have no idea
      # how to override default parameter values; setting 
      # group value to exhibit if request path matches
      # ^exhibit
      if request.path =~ /^\/exhibit/
        params[:group] = 'exhibit'
      end

      @group = params[:group]
      @terms = terms [ @group ]
      groups = { }

      @terms.each do | term |
        name, slug = term['name'], term['slug']

        @listings.each do | listing |
          if listing['tags'].include? slug
            groups[name] ||= [ ]              
            groups[name] << listing
          end
        end
      end

      # if only one group is present, we are looking at 
      # an individual gallery and each item will beome
      # a listing

      if groups.count == 1
        @listings = groups.first[1] 

      # otherwise we pull a random record and collect count information
      # to represent the group
      else
        @listings = [ ]

        groups.each do | name, listings |
          listing                = listings.sample
          listing['description'] = name
          listing['title']       = name
          listing['count']       = listings.length

          @listings << listing
        end
      end
      # collect any uncategorized content

      #unless @listings.empty?
      #  groups['uncategorized']          = @listings.first
      #  groups['uncategorized']['count'] = @listings.count
      #  groups['uncategorized']['group'] = 'uncategorized' 
      #end


    end    


  end
end