class GalleryPiecesController < ApplicationController

  def index
    @gallery = Gallery.find(params[:gallery_id])
    @pieces = @gallery.pieces
  end

end
