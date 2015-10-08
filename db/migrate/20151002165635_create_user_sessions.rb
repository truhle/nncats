class CreateUserSessions < ActiveRecord::Migration
  def change
    create_table :user_sessions do |t|
      t.string :session_token
      t.string :browser
      t.string :device
      t.string :os

      t.timestamps null: false
    end

  add_index :user_sessions, :session_token, unique: true
  end
end
