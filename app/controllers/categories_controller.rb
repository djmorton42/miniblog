class CategoriesController < ApplicationController
  def show
    unescaped_category_name = CGI.unescape(params[:name]).downcase

    @category = Category.where("lower(name) = ?", unescaped_category_name).first

    raise ActionController::RoutingError.new('Not Found') unless @category.present?
    
    @entries = @category.entries.where(is_published: true).order(:published_at).all

    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {})
    @settings = Setting.all.first
    
    @categories = Category
      .order(:name)
      .all
  end
end
