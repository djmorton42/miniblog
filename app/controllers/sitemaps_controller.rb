class SitemapsController < ApplicationController
  skip_after_action :track_request
  
  def show
    @entries = Entry.published_entries_ordered_by_update_date
  end
end
