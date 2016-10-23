module ApplicationHelper

  TIMEZONE = 'America/New_York'

  def format_datetime(datetime)
    datetime.present? ? datetime.in_time_zone(TIMEZONE).strftime('%e %B %Y %l:%M %p %Z') : ""
  end

  def format_sitemap_datetime(datetime)
    datetime.present? ? datetime.in_time_zone(TIMEZONE).strftime('%F') : ""
  end

  def format_rss_datetime(datetime)
    datetime.present? ? datetime.in_time_zone(TIMEZONE).strftime('%a, %d %b %Y %k:%M:%S %Z') : ""
  end
end
