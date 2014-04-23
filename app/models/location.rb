class Location < ActiveRecord::Base
  HTTP_METHODS = %w[GET POST]

  class << self
    def find_by_param(param)
      find_by_id param
    end

    def without_scheduled_ping
      all.reject &:scheduled_ping
    end
  end

  validates :seconds, :presence => true, :numericality => {:if => lambda { seconds.present? }}
  validates :http_method, :inclusion => HTTP_METHODS
  validates :url,
    :presence => true,
    :format => {:with => /\A#{URI.regexp %w(http https)}\z/, :if => lambda { url.present? }}
  validates :title, :presence => true

  # has_many :alerts
  has_many :pings

  def next_ping_time
    (performed_pings.first.try(:performed_at) || created_at) + seconds
  end

  def schedule_ping!
    PingWorker.perform_at(next_ping_time, pings.create!.id)
  end

  def scheduled_ping
    pings.where(:performed_at => nil).first
  end

  def paginated_performed_pings(page: 1, per_page: CONFIG[:app][:pings_per_page])
    performed_pings.page(page).per(per_page)
  end

  private

  def performed_pings
    pings.where('performed_at IS NOT NULL').order('performed_at DESC')
  end
end