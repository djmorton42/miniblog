class Entry < ActiveRecord::Base
  belongs_to :category
  has_many :comments

  validates :title, presence: true, length: { maximum: 100 }
  validates :entry, presence: true
  validates :summary, presence: true

  def self.published_entries_ordered_by_pub_date
    Entry
      .where(is_published: true, is_deleted: false)
      .order(:published_at)
  end

  def self.published_entries_ordered_by_update_date
    Entry
      .where(is_published: true, is_deleted: false)
      .order(:updated_at)
  end

  def self.available_entries_ordered_by_created_date
    Entry
      .where(is_deleted: false)
      .order(:created_at)
  end

  def approved_comments
    comments
      .where(is_deleted: false, is_approved: true)
      .order(:created_at)
  end

  def all_comments
    comments
      .where(is_deleted: false)
      .order(:created_at)
  end
end
