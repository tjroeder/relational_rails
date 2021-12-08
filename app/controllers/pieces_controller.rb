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
    piece = Piece.find(params[:piece][:id])

    piece.update({
      name: params[:piece][:name],
      artist: params[:piece][:artist],
      year: params[:piece][:year],
      original: params[:piece][:original]
      })

    piece.save

    redirect_to "/pieces/#{piece.id}"
  end

  def delete
    Piece.destroy(params[:id])

    redirect_to "/pieces"
  end

end
