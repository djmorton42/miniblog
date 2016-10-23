class BlogController < ApplicationController
  def index
    @entries = Entry.published_entries_ordered_by_pub_date
  end

  def feed
    @entries = Entry.published_entries_ordered_by_pub_date
    @last_build_date = nil

    @entries.each do |entry|
      @last_build_date = entry.published_at if @last_build_date.nil? || entry.published_at > @last_build_date
      @last_build_date = entry.updated_at if @last_build_date.nil? || entry.updated_at > @last_build_date
    end
    puts "Last Build Date: #{@last_build_date} - #{@last_build_date.strftime('%+')}"
  end
end
