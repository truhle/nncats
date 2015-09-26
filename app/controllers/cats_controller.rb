class CatsController < ApplicationController

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to @cat
    else
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
  end

  def index
    @cats = Cat.all
  end

  def new
    @cat = Cat.new
  end

  def show
    @cat = Cat.find(params[:id])
  end

private

  def cat_params
    params.require(:cat).permit(:name, :sex, :color, :birth_date, :description)
  end
end
