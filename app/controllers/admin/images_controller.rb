class Admin::ImagesController < Admin::AdminAreaController
  MAX_FILE_SIZE = 20_000_000
  CONTENT_TYPE_WHITELIST = ['image/jpeg', 'image/gif', 'image/png'].freeze

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
    uploaded_io = params[:image][:upload_file]
   
    image_uuid = SecureRandom.uuid
  
    Image.transaction do

      @image = Image.new
      if uploaded_io.nil?
        @image.errors.add(:upload_file, 'File must be selected to upload')
      elsif uploaded_io.size > MAX_FILE_SIZE
        @image.errors.add(:upload_file, 'File must be less than 20 MB')
      elsif CONTENT_TYPE_WHITELIST.exclude?(uploaded_io.content_type)
        @image.errors.add(:upload_file, 'File must be a jpeg, png or gif')
      else
        @image.title = params[:image][:title] 
        @image.url_token = image_uuid
        @image.file_name = uploaded_io.original_filename
        @image.content_type = uploaded_io.content_type
        @image.save 
      end
      
      if @image.errors.any?
        render :new   
      else
        filename = Rails.root.join('public', 'uploads', image_uuid)

        File.open(filename, 'wb') do |file|
          file.write(uploaded_io.read)
        end 

        redirect_to admin_images_path
      end
    end
  end

  private
  def entry_params
    params
      .require(:image)
      .permit(:title, :upload_file)
  end
end
