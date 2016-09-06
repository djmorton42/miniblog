class BlogController < ApplicationController
  def index
    @entries = Entry
      .where(is_published: true)
      .order(:published_at)
      .all
    @categories = Category
      .order(:name)
      .all
  end
end
