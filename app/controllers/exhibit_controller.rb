class ExhibitController < ApplicationController

  layout 'gallery'

  def past
    # grab past exhibit listings
    @listings = Statement.past_exhibits( tags: @tags )
    
  end

  def current
  end

  def upcoming
  end
end
