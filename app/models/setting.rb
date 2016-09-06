class Setting < ActiveRecord::Base
  belongs_to :banner_image, class_name: 'Image', foreign_key: 'banner_image_id'

  validates :blog_title, presence: true, length: { maximum: 50 }
  validates :blog_subtitle, length: { maximum: 50 }
  validates :bio, presence: false, length: { maximum: 40_000 }
end
