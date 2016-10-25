class HistoricalEntry < ActiveRecord::Base
  belongs_to :category
  belongs_to :parent_entry, class_name: 'Entry', foreign_key: 'parent_entry_id'

  def self.from_entry(entry)
    HistoricalEntry.new(
      title: entry.title,
      entry: entry.entry,
      summary: entry.summary,
      tags: entry.tags,
      category: entry.category,
      parent_entry: entry
    )
  end

  def restore_to_entry(entry)
    return nil unless parent_entry_id == entry.id

    entry.assign_attributes({
      title: self.title,
      entry: self.entry,
      summary: self.summary,
      tags: self.tags,
      category: self.category
    })
  end

end
