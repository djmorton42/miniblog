class AddBannerImageToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :banner_image_id, :integer
    add_foreign_key :settings, :images, column: :banner_image_id, name: 'settings_banner_image_fk', index: true
  end
end
