class Admin::ImagesController < Admin::AdminAreaController
  def index
    @images = Image.available_images

    respond_to do |format|
      format.html
      format.json { render :json => Image.published_images }
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.is_deleted = true
    @image.deleted_at = DateTime.now
    @image.save

    redirect_to admin_images_path
  end

  def publish
    @image = Image.find(params[:id])
    @image.is_published = true
    @image.published_at = DateTime.now
    @image.save

    redirect_to admin_images_path
  end

  def unpublish
    @image = Image.find(params[:id])
    @image.is_published = false
    @image.published_at = nil
    @image.save

    redirect_to admin_images_path
  end

  def new
    @image = Image.new
  end

  def create
    #TODO Add transactional behaviour to delete file if the image can not be created
    uploaded_io = params[:image][:upload_file]
   
    image_uuid = SecureRandom.uuid

    File.open(Rails.root.join('public', 'uploads', image_uuid), 'wb') do |file|
      file.write(uploaded_io.read)
    end 
  
    image = Image.new
    image.title = params[:image][:title] 
    image.url_token = image_uuid
    image.file_name = uploaded_io.original_filename
    image.content_type = uploaded_io.content_type
    image.save 

    redirect_to admin_images_path
  end

  private
  def entry_params
    params
      .require(:image)
      .permit(:title, :upload_file)
  end
end
