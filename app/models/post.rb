class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :image, presence: true
  
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :user

end
