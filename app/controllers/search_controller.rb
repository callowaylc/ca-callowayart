class SearchController < ApplicationController
  include ApplicationHelper

  # use gallery layout
  layout 'gallery'

  def index
    # retrieve upcoming exhibits
    @listings = Statement.search( tags: params[:q].split(' '))
  end
end