class AddRequesterToCatRentalRequest < ActiveRecord::Migration
  def change
    add_reference :cat_rental_requests, :user, index: true, foreign_key: true
  end
end
