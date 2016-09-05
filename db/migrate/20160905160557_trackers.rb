class Trackers < ActiveRecord::Migration
  def change
    create_table :trackers do |t|
      t.integer :status_code, null:false
      t.string :user_agent, null: false
      t.string :source_ip, null: false
      t.string :url, null:false
      t.string :referer
      t.string :accept_language
      t.string :x_forwarded_for
      t.timestamps
    end
  end
end
