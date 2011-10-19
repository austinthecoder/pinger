class Ping < ActiveRecord::Base

  @queue = :high

  belongs_to :location
  has_many :alerts, :through => :location

  validates :location_id, :presence => true

  class << self
    def perform(ping_id)
      find(ping_id).perform!
    end

    # TODO: test
    def first_scheduled
      where { performed_at.eq(nil) }.first
    end

    def performed
      where { performed_at.not_eq(nil) }
    end
  end

  def deliver_applicable_alerts!
    alerts.select(&:conditions_met?).each(&:deliver!)
  end

  # TODO: test
  def perform!
    self.response_status_code = location.request.code
    update_attributes!(:performed_at => Time.now)
    deliver_applicable_alerts!
  end

  def schedule!(perform_at)
    transaction do
      update_attributes!(:perform_at => perform_at)
      Resque.enqueue_at(perform_at, self.class, id)
    end
  end

end
