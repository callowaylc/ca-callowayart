module ApplicationHelper
  def slugify(string)
    unless string.nil?
      slug = string.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '') if string
      slug.gsub( /\-{2,}/, '-' )
    end
  end

  def deslugify(string)
    string.gsub('-', ' ') unless string.nil?
  end

  def uri_for(listing)

    # if listing contains an id, then we build a uri for a individual 
    # listing
    if listing[:id]
      uri  = "/listing"
      uri += "/#{listing[:artist_slug]}" if listing[:artist_slug]
      uri += "/#{listing[:slug]}"

    elsif request.path =~ /exhibit/
      "/exhibit/#{listing[:slug]}"

    else
      request.path + '/' + listing[:slug]      
    end
  end

  def tags
    # basically moving the chaos that is the current route
    # sytem into hte idea of tags; all of this needs to be
    # replaced
    if params[:tags].present?
      tags = params[:tags]
      tags = tags[1..tags.length].split '/'

    else
      tags = [ ]
      tags << params[:resource] if params[:resource].present?
      tags << params[:slug]     if params[:slug ].present? 

    end

    tags << params[:exhibit] if params[:exhibit].present?
    tags
  end


end