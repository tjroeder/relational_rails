class DirectorFilmsController < ApplicationController
  def index
    if params[:sort]
      @director = Director.find(params[:director_id])
      @films = @director.films.order(name: params[:sort])
    else
      @director = Director.find(params[:director_id])
      @films = @director.films
    end
  end

  def new
    @director = Director.find(params[:director_id])
  end
  
  def create
    @director = Director.find(params[:director_id])
    @films = @director.films
    @films.create!(director_film_params)
    
    redirect_to "/directors/#{@director.id}/films"
  end

  private

  def director_film_params
    params.permit(:name, :rt_rank, :nominated)
  end
end