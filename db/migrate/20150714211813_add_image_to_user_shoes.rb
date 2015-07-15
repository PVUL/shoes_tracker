class AddImageToUserShoes < ActiveRecord::Migration
  def change
    add_column :user_shoes, :image, :string
  end
end
