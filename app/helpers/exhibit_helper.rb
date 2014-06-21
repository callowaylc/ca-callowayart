module ExhibitHelper
  def uri_for(listing)
    if listing[:id]
      uri  = "/listing"
      uri += "/#{listing[:artist_slug]}" if listing[:artist_slug]
      uri += "/#{listing[:slug]}"    

    else
      "/exhibit/#{listing[:slug]}"
    end

  end
end
