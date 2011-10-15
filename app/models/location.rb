class Location < ActiveRecord::Base

  class PingScheduler
    @queue = :low

    class << self
      def perform(*args)
        Location.schedule_pings!
      end
    end
  end

  has_many :pings

  validates :seconds,
    :presence => true,
    :numericality => {:if => lambda { seconds.present? }}
  validates :http_method, :format => /(get|post)/i
  validates :url,
    :presence => true,
    :format => {
      :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix,
      :if => lambda { url.present? }
    }
  validates :title, :presence => true

  class << self
    def schedule_pings!
      all.each do |l|
        # if there's no scheduled pings, schedule one
        if l.pings.where { performed_at.eq(nil) }.empty?
          l.pings.new.schedule!
        end
      end
    end
  end

  def next_ping_date
    pings.where { performed_at.eq(nil) }.first.try(:perform_at)
  end

  def request
    HTTParty.send http_method, url
  end

  def http_method=(value)
    self[:http_method] = value ? value.to_s.downcase : nil
  end

end