module GalleryHelper

  def description_for listing
    if listing[:description]
      # remove first line of description if same as title
      # TODO: this is entirely a hack and should be fixed at
      # index time
      description = listing[:description].split( /\n/)
      if description[0].downcase.strip == listing[:title].downcase.strip
        description = description[1..-1]
      end

      description.join '<br />'
    end
                                     
  end

end
