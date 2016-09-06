class AddTitleColorAndCopyrightToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :title_color, :string
    add_column :settings, :copyright, :text
  end
end
