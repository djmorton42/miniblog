class Comments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :response_to_comment_id, null: true
      t.string :commenter_name, null: false
      t.text :comment, null: false
      t.boolean :is_approved, null: false
      t.datetime :approved_at, null: true
      t.boolean :is_deleted, null: false, default: false
      t.datetime :deleted_at, null: true
      t.timestamps
    end

    add_reference :comments, :entry, foreign_key: true
    add_foreign_key :comments, :comments, column: :response_to_comment_id, name: 'response_to_comment_fk', index: true
  end
end
