class Entries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.text :entry, null: false
      t.text :summary, null: false
      t.boolean :is_published, null: false, default: false
      t.datetime :published_at, null: true
      t.text :tags, null: false
    end
  end
end
