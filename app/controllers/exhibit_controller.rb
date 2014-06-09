class ExhibitController < ApplicationController

  layout 'gallery'

  def past
    # grab past exhibit listings
    @listings = Statement.past_exhibits tags: tags 

  end

  def current
    # grab current exhibit listing to get current exhibity
    # slug and 
    current = ( Statement.exhibit tags: [ 'current' ] ).pop

    # grab all images associatdd 
    @listings = Statement.exhibit tags: [slugify(
      current[:exhibit]
    )]
    @name        = @listings[0][:exhibit]
    @description = @listings[0][:exhibit_description] 
  end

  def upcoming
    # retrieve upcoming exhibits
    @listings = Statement.exhibits tags:[ 'upcoming' ] 

  end
end
