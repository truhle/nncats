class CatsController < ApplicationController

  before_action :must_be_logged_in, only: [:create, :edit, :new, :update]
  before_action :cat_owner?, only: [:edit, :update]

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id unless current_user.blank?
    if @cat.save
      redirect_to @cat
    else
      render :new
    end
  end

  def edit
    @cat ||= Cat.find(params[:id])
  end

  def index
    @cats = Cat.all
  end

  def new
    @cat = Cat.new
  end

  def show
    @cat = Cat.find(params[:id])
    @rental_requests = CatRentalRequest.includes(:requester).where(cat_id: params[:id]).order(:start_date)
  end

private

  def cat_params
    params.require(:cat).permit(:name, :sex, :color, :birth_date, :description)
  end

  def cat_id
    params[:id]
  end

end
