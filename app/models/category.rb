class Category < ActiveRecord::Base
  has_many :entries

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }

  def entry_count
    self
      .entries
      .where(is_published: true, is_deleted: false)
      .count
  end

  def self.find_for_lower_case_name(name)
    Category
      .where("lower(name) = ?", name)
      .first
  end

  def published_entries_ordered_by_pub_date
    self
      .entries
      .where(is_published: true, is_deleted: false)
      .order(:published_at)
  end

end
