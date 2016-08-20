class Admin::EntriesController < Admin::AdminAreaController
  def index
    @entries = Entry
      .where(is_deleted: false)
      .order(:created_at)
      .all
  end

  def edit
    @entry = Entry.find(params[:id])
    render :new
  end

  def update
    @entry = Entry.find(params[:id])
    @entry.update_attributes(entry_params)

    redirect_to admin_entries_path
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
  end

  def create
    Entry.create(entry_params)   

    redirect_to admin_entries_path
  end

  private
  def entry_params
    params
      .require(:entry)
      .permit(:title, :tags, :entry, :summary)
  end
end
