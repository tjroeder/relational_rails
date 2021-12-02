class GalleriesController < ApplicationController

  def index
    # @directors = Director.all
    @galleries = Gallery.all
  end

  def show

  end

end
