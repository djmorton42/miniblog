class Category < ActiveRecord::Base
  has_many :entries

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }

  def entry_count
    self
      .entries
      .where(is_published: true, is_deleted: false)
      .count
  end
end
