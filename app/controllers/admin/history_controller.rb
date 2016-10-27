class Admin::HistoryController < Admin::AdminAreaController
  def index
    @entry = Entry.find(params[:entry_id])
    @historical_entries = @entry.historical_entries.order(:created_at)
  end

  def show
    @entry = Entry.find(params[:entry_id])
    @historical_entry = @entry.historical_entries.where(id: params[:id]).first

    raise ActionController::RoutingError.new('Not Found') if @historical_entry.nil?

    renderer = Redcarpet::Render::HTML.new(escape_html: true)
    @markdown = Redcarpet::Markdown.new(renderer, extensions = {})
    @settings = Setting.all.first
  end

  def restore
    @entry = Entry.find(params[:entry_id])
    @historical_entry = @entry.historical_entries.where(id: params[:id]).first

    raise ActionController::RoutingError.new('Not Found') if @historical_entry.nil?
    
    Entry.transaction do
      new_historical_entry = HistoricalEntry.from_entry(@entry)
      @historical_entry.restore_to_entry(@entry)

      new_historical_entry.save
      @entry.save
    end
    redirect_to admin_entries_path
  end
end
