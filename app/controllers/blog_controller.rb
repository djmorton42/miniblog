class BlogController < ApplicationController
  def index
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {})
    @settings = Setting.all.first
    @entries = Entry
      .where(is_published: true)
      .order(:published_at)
      .all
    @categories = Category
      .order(:name)
      .all
  end
end
