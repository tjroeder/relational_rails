class DirectorFilmsController < ApplicationController
  def index
    @director = Director.find(params[:director_id])
    @films = @director.films
  end
end