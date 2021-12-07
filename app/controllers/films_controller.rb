class FilmsController < ApplicationController
  before_action :set_film, only: [:show, :edit, :update, :destroy]

  def index
    @films = Film.all
  end

  def show
  end

  def edit
  end

  def update
    @film.update(films_params)
    redirect_to "/films/#{@film.id}"
  end

  def destroy
    @film.destroy
    redirect_to '/films'
  end

  private

  def films_params
    params.permit(:name, :rt_rank, :nominated)
  end

  def set_film
    @film = Film.find(params[:id])
  end
end