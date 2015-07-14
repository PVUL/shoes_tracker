class Shoe < ActiveRecord::Base
  has_many :user_shoes
  has_many :users, through: :user_shoes

  validates :brand, presence: true
  validates :model, presence: true
  validates :color, presence: true
end
