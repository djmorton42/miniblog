class HistoricalEntries < ActiveRecord::Migration
  def change
    create_table :historical_entries do |t|
      t.string :title, null: false
      t.text :entry, null: false
      t.text :summary, null: false
      t.text :tags, null: false
      t.timestamps
    end

    add_reference :historical_entries, :category, index: true, null: false         
    add_foreign_key :historical_entries, :categories, name: "historical_entry_category_fk"

    add_reference :historical_entries, :parent_entry, index: true, null: false
    add_foreign_key :historical_entries, :entries, column: 'parent_entry_id', name: "historical_entry_entry_fk"
  end
end
