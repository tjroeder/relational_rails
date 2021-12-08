class DirectorFilmsController < ApplicationController
  before_action :set_director, only: [:index, :new, :create]
  before_action :set_films, only: [:index, :create]

  def index
    if params[:sort]
      @films = @films.order(name: params[:sort])
    elsif params[:filter]
      @films = @films.where("rt_rank > ?", params[:filter])
    end
  end

  def new
  end
  
  def create
    @films.create!(director_film_params)
    redirect_to "/directors/#{@director.id}/films"
  end

  private

  def director_film_params
    params.permit(:name, :rt_rank, :nominated)
  end

  def set_director
    @director = Director.find(params[:director_id])
  end

  def set_films
    @films = @director.films
  end
end