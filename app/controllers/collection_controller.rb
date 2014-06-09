class CollectionController < ApplicationController
  layout 'gallery'


  def index
    @listings = Statement.collection tags: tags

    if @listings.count > 0
      @name      = @listings[0][:artist]
      @description = @listings[0][:artist_description] 
    end

  end

end
