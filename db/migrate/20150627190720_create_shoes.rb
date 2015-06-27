class CreateShoes < ActiveRecord::Migration
  def change
    create_table :shoes do |t|
      t.string :model
      t.string :brand
      t.string :color

      t.timestamps null: false
    end
  end
end
