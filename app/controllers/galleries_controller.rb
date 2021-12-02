class GalleriesController < ApplicationController

  def index
    # @directors = Director.all
    @galleries = Gallery.all
  end

  def show
    @gallery = Gallery.find(params[:id])
  end

end
