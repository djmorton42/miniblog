class Admin::SettingsController < Admin::AdminAreaController

  def show
    @settings = Setting.all.first 
    render :edit
  end

  def update
    @settings = Setting.all.first

    @settings.update_attributes(settings_params)

    if @settings.errors.any?
      render :edit
    else
      redirect_to admin_root_path
    end
  end

  def settings_params
    params
      .require(:setting)
      .permit(:blog_title, :blog_subtitle, :display_bio, :bio)
  end
end
