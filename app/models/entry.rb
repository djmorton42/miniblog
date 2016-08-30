class Entry < ActiveRecord::Base
  belongs_to :category

  validates :title, presence: true, length: { maximum: 100 }
  validates :entry, presence: true
  validates :summary, presence: true
end
