class GalleryPiecesController < ApplicationController
  before_action :set_gallery, only: [:index, :new, :create]

  def index
    if params[:sort]
      @pieces = @gallery.pieces.order(name: params[:sort])
    elsif params[:filter]
      @pieces = @gallery.pieces.created_after( params[:filter])
    else
      @pieces = @gallery.pieces
    end
  end

  def new
  end

  def create
    piece = @gallery.pieces.create(gallery_pieces_params)

    redirect_to "/galleries/#{@gallery.id}/pieces"
  end

  private

  def gallery_pieces_params
    params.permit(:name, :artist, :year, :original, :gallery_id)
  end

  def set_gallery
    @gallery = Gallery.find(params[:gallery_id])
  end

end
