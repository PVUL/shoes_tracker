class UserShoe < ActiveRecord::Base
  belongs_to :user
  belongs_to :shoe

  has_many :check_ins

  mount_uploader :image, ImageUploader

  # def image=(val)
  #   if !val.is_a?(String) && valid?
  #     image_will_change!
  #     super
  #   end
  # end

end
