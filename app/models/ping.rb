class Ping < ActiveRecord::Base

  @queue = :high

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

  def schedule!(perform_at)
    transaction do
      update_attributes!(:perform_at => perform_at)
      Resque.enqueue_at(perform_at, self.class, id)
    end
  end

end
