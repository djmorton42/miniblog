module ApplicationHelper

  TIMEZONE = 'America/New_York'

  def format_datetime(datetime)
    datetime.in_time_zone(TIMEZONE).strftime('%e %B %Y %l:%M %p %Z')
  end

  def format_sitemap_datetime(datetime)
    datetime.in_time_zone(TIMEZONE).strftime('%Y-%m-%d')
  end
end
