class Admin::SettingsController < Admin::AdminAreaController

  def show
    @settings = Setting.all.first 
    @images = Image.where(is_published: true).order(:title).all
    render :edit
  end

  def update
    @settings = Setting.all.first

    @settings.update_attributes(settings_params)

    if @settings.errors.any?
      @images = Image.where(is_published: true).order(:title).all
      render :edit
    else
      redirect_to admin_root_path
    end
  end

  def settings_params
    params
      .require(:setting)
      .permit(
        :blog_title, 
        :blog_subtitle, 
        :title_color, 
        :display_bio, 
        :bio, 
        :banner_image_id, 
        :copyright)
  end
end
