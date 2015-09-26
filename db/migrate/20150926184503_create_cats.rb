class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.date :birth_date
      t.string :color
      t.string :name
      t.string :sex, limit: 1
      t.text :description

      t.timestamps null: false
    end
  end
end
