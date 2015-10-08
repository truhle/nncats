class RemoveSessionTokenFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :session_token, :string, index: true, unique: true
  end
end
