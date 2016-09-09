class Image < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 50 }

  def self.query
    Image
  end

  def self.find_published_by_token(url_token) 
    Image
      .where(url_token: url_token, is_published: true, is_deleted: false)
      .first
  end

  def self.published_images_ordered_by_title
    Image
      .where(is_published: true, is_deleted: false)
      .order(:title)
  end

  def self.published_images_ordered_by_pub_date
    Image
      .where(is_published: true, is_deleted: false)
      .order(published_at: :desc)
  end

  def self.published_images
    Image
      .where(is_published: true, is_deleted: false)
  end

  def self.available_images
    Image
      .where(is_deleted: false)
  end

  def self.available_images_ordered_by_crated_date
    Image
      .where(is_deleted: false)
      .order(:created_at)
  end
end
