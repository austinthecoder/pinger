class Ping < ActiveRecord::Base

  @queue = :pings

  belongs_to :location

  validates :location_id, :presence => true

  class << self
    def perform(ping_id)
      find(ping_id).perform!
    end
  end

  def perform!
    self.response_status_code = location.request.code
  ensure
    update_attributes!(:performed_at => Time.now)
  end

  def schedule!
    newest_performed_ping = location.pings.order { performed_at.desc }.first
    self.perform_at = (newest_performed_ping.try(:performed_at) || Time.now) + location.seconds
    save!
    Resque.enqueue_at(perform_at, self.class, id)
  end

end
