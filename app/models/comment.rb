class Comment < ActiveRecord::Base
  belongs_to :response_to_comment, class_name: 'Comment', foreign_key: 'response_to_commend_id'
  belongs_to :entry

  validates :commenter_name, presence: true, length: { maximum: 100 }
  validates :comment, presence: true, length: { maximum: 4096 }

  def approved
    Comment
      .where(is_deleted: false, is_approved: true)
      .order(:created_at)
  end

  def unapproved
    Comment
      .where(is_deleted: false, is_approved: false)
      .order(:created_at)
  end
  
  def all
    Comment
      .where(is_deleted: false)
      .order(:created_at)
  end

end
