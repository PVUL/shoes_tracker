class CreateCheckIns < ActiveRecord::Migration
  def change
    create_table :check_ins do |t|
      t.belongs_to :user_shoe, null: false
      t.string :date, null: false

      t.timestamps null: false
    end
  end
end
