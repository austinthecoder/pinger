class Ping < ActiveRecord::Base
  class Performer
    def initialize(ping)
      @ping = ping
    end

    def perform!
      begin
        response = HTTParty.send ping.http_method.downcase, ping.url
        self.response_status_code = response.code
      ensure
        ping.update_attributes! :performed_at => Time.zone.now
      end

      ping.performed!
    end

  private
    attr_reader :ping
  end

  @queue = :high

  belongs_to :location

  validates :location_id, :presence => true

  class << self
    def all_for_location_id(location_id)
      where { |q| q.location_id.eq location_id }
    end

    def performed
      where { performed_at.not_eq nil }
    end

    def scheduled
      where { performed_at.eq nil }
    end

    def perform(ping_id)
      find(ping_id).perform!
    end

    def schedule!(attrs = {})

    end
  end

  delegate :http_method, :url, :to => :location

  def perform!
    Performer.new(self).perform!
  end

  def performed!
    location.ping_performed! self
  end

  def schedule!

  end

  def performed?
    performed_at
  end

end
