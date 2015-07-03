class CreateUserShoes < ActiveRecord::Migration
  def change
    create_table :user_shoes do |t|
      t.belongs_to :user, null: false
      t.belongs_to :shoe, null: false

      t.timestamps null: false
    end
  end
end
