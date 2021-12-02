class GalleriesController < ApplicationController

  def index
    # @directors = Director.all
    @galleries = Gallery.all
  end

end
