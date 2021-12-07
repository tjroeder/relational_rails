class DirectorsController < ApplicationController
  before_action :set_director, only: [:show, :edit, :update, :destroy]

  def index
    @directors = Director.all
  end

  def show
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

  def edit
  end
  
  def update
    @director.update(director_params)
    redirect_to "/directors/#{@director.id}"
  end

  def destroy
    @director.destroy
    redirect_to "/directors"
  end

  private

  def director_params
    params.permit(:name, :imdb_rank, :tv_credit)
  end

  def set_director
    @director = Director.find(params[:id])
  end
end