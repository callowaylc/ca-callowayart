class ExhibitController < ApplicationController

  layout 'gallery'

  def past
    # grab past exhibit listings
    @listings = Statement.past_exhibits tags: tags 

  end

  def current
    # grab current exhibit listing and all exhibits
    # and proceed to iterate through group to find exhibit
    # name
    current = ( Statement.exhibit tags: [ 'current' ] ).pop

    # grab all exhibits names


    @listings = Statement.exhibit tags: [slugify(
      current[:exhibit]
    )]

    raise @listings.to_s




  end

  def upcoming
  end
end
