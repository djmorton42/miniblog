class CreateTrackersSummaryView < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE VIEW tracker_summary AS (
        SELECT url, visitor_id, source_ip, user_agent, min(created_at) as created_at 
        FROM trackers 
        GROUP BY url, visitor_id, source_ip, user_agent
        ORDER BY url, created_at
      )
    SQL
  end

  def down
    execute "DROP VIEW tracker_summary"
  end
end
