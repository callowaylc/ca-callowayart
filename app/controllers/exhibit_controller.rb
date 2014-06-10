class ExhibitController < ApplicationController

  layout 'gallery'

  def past
    # grab past exhibit listings
    @listings = Statement.past_exhibits

    # sort listings 
    # TODO: this should be done in elasticsearch statement
    # ie must learn more
    # NOTE: Nil#to_i evaluates to 0
    @listings.sort! { | a, b | b[:exhibit_start].to_i <=> a[:exhibit_start].to_i }
  
  end

  def current
    # grab current exhibit listing to get current exhibity
    # slug and 
    current = ( Statement.exhibit tags: [ 'current' ] ).pop

    load current[:exhibit_slug]
  end

  def upcoming
    # retrieve upcoming exhibits
    @listings = Statement.exhibits tags:[ 'upcoming' ] 

  end

  def show
    load params[:exhibit]
  end

  private

    def load(tag) 
      # grab all images associatdd 
      @listings = Statement.exhibit tags: [ tag ]
      @name        = @listings[0][:exhibit]
      @description = @listings[0][:exhibit_description] 
    end
end
