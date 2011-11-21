class Ping < ActiveRecord::Base

  extend Paginates

  @queue = :high

  belongs_to :location
  has_many :alerts, through: :location

  validates :location_id, presence: true

  class << self
    # TODO: test
    def perform(ping_id)
      find(ping_id).perform!
    end

    def first_scheduled
      where { performed_at.eq nil }.first
    end

    def performed
      where { performed_at.not_eq nil }
    end
  end

  def deliver_applicable_alerts!
    alerts.select(&:conditions_met?).each &:deliver!
  end

  def perform!
    self.performed_at = Time.now
    update_attributes! response_status_code: location.perform_request.code
    deliver_applicable_alerts!
  ensure
    save!
  end

  def schedule!(perform_at)
    transaction do
      update_attributes! perform_at: perform_at
      Resque.enqueue_at perform_at, self.class, id
    end
  end

  def to_presenter(view)
    Presenter.new self, view
  end

end
