class DirectorsController < ApplicationController
  def index
    @directors = Director.all.order(created_at: :desc)
  end

  def show
    @director = Director.find(params[:id])
  end
end