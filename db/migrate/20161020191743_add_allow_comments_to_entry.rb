class AddAllowCommentsToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :allow_comments, :boolean, null: false, default: true
  end
end
