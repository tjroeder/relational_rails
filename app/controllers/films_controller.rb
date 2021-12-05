class FilmsController < ApplicationController
  def index
    @films = Film.all
  end

  def show
    @film = Film.find(params[:id])
  end

  def edit
    @film = Film.find(params[:id])
  end

  def update
    @film = Film.find(params[:id])
    @film.update(films_params)
    redirect_to "/films/#{@film.id}"
  end

  private

  def films_params
    params.permit(:name, :rt_rank, :nominated)
  end
end