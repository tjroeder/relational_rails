class DirectorsController < ApplicationController
  def index
    @directors = Director.all
  end

  def show
    @director = Director.find(params[:id])
  end

  def new
    @director = Director.new
  end

  def create
    # @director = Director.new(director_params)
    # @director.save
    @director = Director.create!(director_params)

    redirect_to '/directors'
  end

  private

  def director_params
    params.permit(:name, :imdb_rank, :tv_credit)
  end
end