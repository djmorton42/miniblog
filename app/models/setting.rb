class Setting < ActiveRecord::Base
  validates :blog_title, presence: true, length: { maximum: 50 }
  validates :blog_subtitle, length: { maximum: 50 }
  validates :bio, presence: false, length: { maximum: 40_000 }

end
