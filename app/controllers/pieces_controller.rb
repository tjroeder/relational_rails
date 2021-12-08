class PiecesController < ApplicationController
  before_action :set_piece, only: [:show, :edit, :update, :delete]

  def index
    @pieces = Piece.all
  end

  def show
  end

  def edit
  end

  def update
    @piece.update(piece_params)

    redirect_to "/pieces/#{@piece.id}"
  end

  def delete
    @piece.destroy

    redirect_to "/pieces"
  end

  private

  def piece_params
    params.permit(:name, :artist, :year, :original)
  end

  def set_piece
    @piece = Piece.find(params[:id])
  end
end
