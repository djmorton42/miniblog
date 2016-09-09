class Admin::EntriesController < Admin::AdminAreaController
  def index
    @entries = Entry.available_entries_ordered_by_created_date
  end

  def edit
    @entry = Entry.find(params[:id])
    @categories = Category.all
    render :new
  end

  def update
    @entry = Entry.find(params[:id])
    @entry.update_attributes(entry_params)

    if @entry.errors.any?
      @categories = Category.all
      render :new 
    else
      redirect_to admin_entries_path
    end
  end

  def destroy
    @entry = Entry.find(params[:id])
    @entry.is_deleted = true
    @entry.deleted_at = DateTime.now
    @entry.save

    redirect_to admin_entries_path
  end

  def publish
    @entry = Entry.find(params[:id])
    @entry.is_published = true
    @entry.published_at = DateTime.now
    @entry.save

    redirect_to admin_entries_path
  end

  def unpublish
    @entry = Entry.find(params[:id])
    @entry.is_published = false
    @entry.published_at = nil
    @entry.save

    redirect_to admin_entries_path
  end

  def new
    @entry = Entry.new
    @categories = Category.all
  end

  def create
    @entry = Entry.create(entry_params)   

    if @entry.errors.any?
      @categories = Category.all
      render :new
    else
      redirect_to admin_entries_path
    end

  end

  private
  def entry_params
    params
      .require(:entry)
      .permit(:title, :tags, :entry, :summary, :category_id)
  end
end
