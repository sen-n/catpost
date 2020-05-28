class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :likes
  has_many :like_posts, through: :likes, source: :user

end
