class Shoe < ActiveRecord::Base
  has_many :user_shoes
  has_many :users, through: :user_shoes
end
