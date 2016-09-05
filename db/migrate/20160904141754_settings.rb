class Settings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :blog_title, null: false
      t.string :blog_subtitle, null: false
      t.boolean :display_bio, null: false
      t.text :bio, null: false
      t.timestamps
    end
  end
end
