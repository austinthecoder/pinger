class Ping < ActiveRecord::Base
  belongs_to :location
  # has_many :alerts, through: :location

  # validates :location_id, presence: true

  # class << self
  #   # TODO: test
  #   def perform(ping_id)
  #     find(ping_id).perform!
  #   end

  #   def first_scheduled
  #     where { performed_at.eq nil }.first
  #   end

  #   def performed
  #     where { performed_at.not_eq nil }
  #   end
  # end

  # def deliver_applicable_alerts!
  #   alerts.select(&:conditions_met?).each &:deliver!
  # end

  def perform!
    self.performed_at = Time.now
    update_attributes! response_status_code: HTTParty.send(location.http_method.downcase, location.url).code
    # deliver_applicable_alerts!
  ensure
    save!
  end
end
