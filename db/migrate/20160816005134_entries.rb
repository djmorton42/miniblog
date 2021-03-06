class Entries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :title, null: false
      t.text :entry, null: false
      t.text :summary, null: false
      t.boolean :is_published, null: false, default: false
      t.datetime :published_at, null: true
      t.boolean :is_deleted, null: false, default: false
      t.datetime :deleted_at, null: true
      t.text :tags, null: false
      t.timestamps
    end

    add_reference :entries, :category, index: true, null: false         
    add_foreign_key :entries, :categories, name: "entry_category_fk"

  end
end
