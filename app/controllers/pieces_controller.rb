class PiecesController < ApplicationController

  def index
    @pieces = Piece.all
  end

  def show
    @piece = Piece.find(params[:id])
  end

  def edit
    @piece = Piece.find(params[:id])
  end

  def update
    piece = Piece.find(params[:id])

    piece.update({
      name: params[:name],
      artist: params[:artist],
      year: params[:year],
      original: params[:original]
      })

    piece.save

    redirect_to "/pieces/#{piece.id}"
  end

  def delete
    Piece.destroy(params[:id])

    redirect_to "/pieces"
  end

end
