class BlogController < ApplicationController
  def index
    @entries = Entry
      .where(is_published: true)
      .order(:published_at)
      .all
  end
end
