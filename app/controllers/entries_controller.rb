class EntriesController < ApplicationController
  def show
    @entry = Entry.find(params[:id])
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {})
    @settings = Setting.all.first
    @categories = Category.order(:name)
    raise ActionController::RoutingError.new('Not Found') unless @entry.is_published || session[:current_user_id].present?
  end
end
