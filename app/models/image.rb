class Image < ActiveRecord::Base
  def self.published_images
    Image
      .where(is_published: true)
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
