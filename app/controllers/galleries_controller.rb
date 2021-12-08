class GalleriesController < ApplicationController

  def index
    @galleries = Gallery.order(created_at: :desc)
  end

  def show
    @gallery = Gallery.find(params[:id])
  end

  def new
  end

  def create
    gallery = Gallery.new({
      name: params[:name],
      entry_cost: params[:entry_cost],
      non_profit: params[:non_profit]
      })

    gallery.save

    redirect_to '/galleries'
  end

  def edit
    @gallery = Gallery.find(params[:id])
  end

  def update
    gallery = Gallery.find(params[:id])
    gallery.update({
      name: params[:name],
      entry_cost: params[:entry_cost],
      non_profit: params[:non_profit]
      })

    gallery.save

    redirect_to "/galleries/#{gallery.id}"
  end

  def delete
    gallery = Gallery.find(params[:id])
    pieces = gallery.pieces.all

    pieces.each do |piece|
      Piece.destroy(piece.id)
    end

    Gallery.destroy(gallery.id)

    redirect_to "/galleries"
  end
end
