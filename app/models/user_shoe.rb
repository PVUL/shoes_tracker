class UserShoe < ActiveRecord::Base
  belongs_to :user
  belongs_to :shoe

  has_many :check_ins

  mount_uploader :image, ImageUploader
end
