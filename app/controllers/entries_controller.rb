class EntriesController < ApplicationController
  def show
    @entry = Entry.find(params[:id])
    @categories = Category.order(:name)
    raise ActionController::RoutingError.new('Not Found') unless @entry.is_published || session[:current_user_id].present?
  end
end