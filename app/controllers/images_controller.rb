class ImagesController < ApplicationController
  def show
    image = Image.where(url_token: params[:id], is_published: true).first

    ActionController::RoutingError.new('Not Found') unless image.present?

    file_name_on_disk = Rails.root.join('public', 'uploads', image.url_token)
    
    send_data(open(file_name_on_disk, "rb") { |f| f.read }, type: image.content_type, disposition: 'inline')
  end

  def index
    images = Image.where(is_published: true).order(published_date: :desc)
  end
end
