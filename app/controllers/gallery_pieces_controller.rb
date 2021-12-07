class GalleryPiecesController < ApplicationController

  def index
    @gallery = Gallery.find(params[:gallery_id])

    if params[:sort]
      @pieces = @gallery.pieces.order(name: params[:sort])
    elsif params[:filter]
      @pieces = @gallery.pieces.created_after( params[:filter])
    else
      @pieces = @gallery.pieces
    end
  end

  def new
    @gallery = Gallery.find(params[:gallery_id])
  end

  def create
    gallery = Gallery.find(params[:piece][:gallery_id])

    piece = gallery.pieces.new({
      name: params[:piece][:name],
      artist: params[:piece][:artist],
      year: params[:piece][:year],
      original: params[:piece][:original]
      })

    gallery.save

    redirect_to "/galleries/#{gallery.id}/pieces"
  end

end
