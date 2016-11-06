class BlogController < ApplicationController
  skip_after_action :track_request, only: [:feed]

  def index
    @entries = Entry.published_entries_ordered_by_pub_date_desc
  end

  def feed
    @entries = Entry.published_entries_ordered_by_pub_date
    @last_build_date = nil

    @entries.each do |entry|
      @last_build_date = entry.published_at if @last_build_date.nil? || entry.published_at > @last_build_date
      @last_build_date = entry.updated_at if @last_build_date.nil? || entry.updated_at > @last_build_date
    end
  end
end
