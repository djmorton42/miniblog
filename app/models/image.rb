class Image < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 50 }

  def self.published_images
    Image
      .where(is_published: true, is_deleted: false)
      .order(published_at: :desc)
      .all
  end

  def self.available_images
    Image
      .where(is_deleted: false)
      .order(:created_at)
      .all
  end
end
