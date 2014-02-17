class GalleryController < ApplicationController
  def index
  	@page = params[:page]
  	@tags = params[:tags].split
  	
  	
  end
end
