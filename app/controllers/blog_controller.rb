class BlogController < ApplicationController
  def index
    @entries = Entry.published_entires_ordered_by_pub_date
  end
end
