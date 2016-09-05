class ImagesController < ApplicationController
  def show
    image = Image.where(url_token: params[:id], is_published: true).first

    ActionController::RoutingError.new('Not Found') unless image.present?

    send_image(image.url_token, image.content_type)
  end

  def banner
    settings = Setting.all.first
    banner_image = settings.banner_image

    response.headers["Expires"] = 1.hour.from_now.httpdate
    if banner_image.present? && banner_image.is_published?
      send_image(banner_image.url_token, banner_image.content_type)
    else
      head :no_content
    end
  end

  def send_image(token, content_type)
    file_name_on_disk = Rails.root.join('public', 'uploads', token)
    send_data(open(file_name_on_disk, "rb") { |f| f.read }, type: content_type, disposition: 'inline')
  end

  def index
    images = Image.where(is_published: true).order(published_date: :desc)
  end
end
