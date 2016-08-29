class Images < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :title, null: false
      t.string :url_token, null: false
      t.string :file_name, null: false
      t.string :content_type, null: false
      t.boolean :is_published, null: false, default: false
      t.datetime :published_at, null: true
      t.boolean :is_deleted, null: false, default: false
      t.datetime :deleted_at, null: true
      t.timestamps
    end
  end
end
