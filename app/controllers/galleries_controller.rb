class GalleriesController < ApplicationController

  def index
    @galleries = Gallery.order(created_at: :desc)
  end

  def show
    @gallery = Gallery.find(params[:id])
  end

  def new
  end

  def create
    gallery = Gallery.new({
      name: params[:gallery][:name],
      entry_cost: params[:gallery][:entry_cost],
      non_profit: params[:gallery][:non_profit]
      })

    gallery.save

    redirect_to '/galleries'
  end

  def edit
    @gallery = Gallery.find(params[:id])
  end

  def update
    gallery = Gallery.find(params[:id])

    gallery.update({
      name: params[:gallery][:name],
      entry_cost: params[:gallery][:entry_cost],
      non_profit: params[:gallery][:non_profit]
      })

    gallery.save

    redirect_to "/galleries/#{gallery.id}"
  end

end
