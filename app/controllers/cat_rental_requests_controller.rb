class CatRentalRequestsController < ApplicationController

  def approve
    @cat_rental_request = CatRentalRequest.find(params[:id])
    if @cat_rental_request.approve!
      redirect_to cat_url(@cat_rental_request.cat_id)
    else
      @cat = Cat.find(@cat_rental_request.cat_id)
      @rental_requests = CatRentalRequest.where(cat_id: @cat_rental_request.cat_id).order(:start_date)
      render 'cats/show'
    end
  end

  def deny
    @cat_rental_request = CatRentalRequest.find(params[:id])
    if @cat_rental_request.deny!
      redirect_to cat_url(@cat_rental_request.cat_id)
    else
      @cat = Cat.find(@cat_rental_request.cat_id)
      @rental_requests = CatRentalRequest.where(cat_id: @cat_rental_request.cat_id).order(:start_date)
      render 'cats/show'
    end
  end

  def new
    @cat_rental_request = CatRentalRequest.new
    @cats = Cat.all
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    if @cat_rental_request.save
      redirect_to cat_url(@cat_rental_request.cat_id)
    else
      @cats = Cat.all
      render :new
    end
  end


private

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
