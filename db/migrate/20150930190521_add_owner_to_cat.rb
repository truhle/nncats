class AddOwnerToCat < ActiveRecord::Migration
  def change
    add_reference :cats, :user, index: true, foreign_key: true
  end
end
