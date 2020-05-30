class Post < ApplicationRecord
  
  validates :image, presence: true
  
  mount_uploader :image, ImageUploader
  
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :user

end
