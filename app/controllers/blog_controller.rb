class BlogController < ApplicationController
  def index
    @entries = Entry
      .where(is_published: true, is_deleted: false)
      .order(:published_at)
      .all
  end
end
