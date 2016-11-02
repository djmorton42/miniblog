class AddVisitorIdToTracker < ActiveRecord::Migration
  def change
    add_column :trackers, :visitor_id, :string, null: true
  end
end
