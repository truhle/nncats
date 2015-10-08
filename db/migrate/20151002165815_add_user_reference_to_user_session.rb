class AddUserReferenceToUserSession < ActiveRecord::Migration
  def change
    add_reference :user_sessions, :user, index: true, foreign_key: true
  end
end
