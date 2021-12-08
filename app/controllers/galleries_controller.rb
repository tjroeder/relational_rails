class GalleriesController < ApplicationController
  before_action :set_gallery, only: [:show, :edit, :update, :delete]

  def index
    @galleries = Gallery.all
  end

  def show
  end

  def new
  end

  def create
    gallery = Gallery.create(gallery_params)

    redirect_to '/galleries'
  end

  def edit
  end

  def update
    @gallery.update(gallery_params)
    redirect_to "/galleries/#{@gallery.id}"
  end

  def delete
    pieces = @gallery.pieces.all

    pieces.each do |piece|
      Piece.destroy(piece.id)
    end

    Gallery.destroy(@gallery.id)

    redirect_to "/galleries"
  end

  private

  def gallery_params
    params.permit(:name, :entry_cost, :non_profit)
  end

  def set_gallery
    @gallery = Gallery.find(params[:id])
  end
end
