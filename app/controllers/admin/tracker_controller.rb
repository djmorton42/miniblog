class Admin::TrackerController < Admin::AdminAreaController
  class VisitorSummary
    attr_accessor :url
    attr_accessor :last_sixty_minutes
    attr_accessor :today
    attr_accessor :yesterday
    attr_accessor :last_seven_days
    attr_accessor :total

    def initialize(url)
      self.url = url;
      self.last_sixty_minutes = 0
      self.today = 0
      self.yesterday = 0
      self.last_seven_days = 0
      self.total = 0
    end
  end

  class Visitor
    attr_accessor :visitor_id
    attr_accessor :ip
    attr_accessor :user_agent

    def ==(other)
      return false unless other.respond_to?('visitor_id') && other.respond_to?('ip') && other.respond_to?('user_agent')

      return true if other.visitor_id.present? && self.visitor_id.present? && other.visitor_id = self.visitor_id
 
      return other.ip_agent_string == self.ip_agent_string
    end

    def ip_agent_string
      "#{self.ip}-#{self.user_agent}"
    end
  end

  class VisitorTracking
    attr_accessor :visitor
    attr_accessor :visitor_summary

    def initialize(visitor, url)
      self.visitor = visitor
      self.visitor_summary = VisitorSummary.new(url)
    end
  end

  def index
#    last_sixty_minutes = Time.now - 60.minutes
#    today = Time.now.beginning_of_day
#    yesterday = today - 1.day
#    last_seven_days = today - 7.days
   
    @url_count_map = Hash.new(0)

    TrackerSummary.all.each do |summary|
      @url_count_map[summary.url] += 1
    end

#    puts "Last 60: #{last_sixty_minutes}, today: #{today}, yesterday: #{yesterday}, last seven: #{last_seven_days}"

#    summaries.find_each do |summary|
#
#    end


  end
end
