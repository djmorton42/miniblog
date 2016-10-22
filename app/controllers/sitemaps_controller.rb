class SitemapsController < ApplicationController
  def show
    @entries = Entry.published_entries_ordered_by_update_date
  end
end
