class AddRequireCommentApprovalToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :require_comment_approval, :boolean, null: false, default: false
  end
end
