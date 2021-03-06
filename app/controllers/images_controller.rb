class ImagesController < ApplicationController
  skip_before_action :populate_default_models 
  skip_after_action :track_request

  def show
    image = Image.find_published_by_token(params[:id]) 

    ActionController::RoutingError.new('Not Found') unless image.present?

    send_image(image.url_token, image.content_type)
  end

  def banner
    settings = Setting.get
    banner_image = settings.banner_image

    response.headers["Expires"] = 1.hour.from_now.httpdate
    if banner_image.present? && banner_image.is_published?
      send_image(banner_image.url_token, banner_image.content_type)
    else
      head :no_content
    end
  end

  def index
    images = Image.published_images_ordered_by_pub_date
  end
 
  private

  def send_image(token, content_type)
    file_name_on_disk = Rails.root.join('public', 'uploads', token)
    send_data(open(file_name_on_disk, "rb") { |f| f.read }, type: content_type, disposition: 'inline')
  end
end
