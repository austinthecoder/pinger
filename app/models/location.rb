class Location < ActiveRecord::Base

  extend Paginates

  HTTP_METHODS = %w(get post)

  has_many :alerts
  has_many :pings

  validates :seconds,
    :presence => true,
    :numericality => {:if => lambda { seconds.present? }}
  validates :http_method, :inclusion => HTTP_METHODS
  validates :url,
    :presence => true,
    :format => {
      :with => /\A#{URI.regexp %w(http https)}\z/,
      :if => lambda { url.present? }
    }
  validates :title, :presence => true

  class << self
    # if there's no scheduled pings, schedule one
    def schedule_pings!
      all.each { |l| l.schedule_ping! unless l.pings.first_scheduled }
    end
  end

  def perform_request
    HTTParty.send http_method, url
  end

  def http_method=(value)
    self[:http_method] = value ? value.to_s.downcase : nil
  end

  def schedule_ping!
    last_ping_at = pings.order { performed_at.desc }.first.try :performed_at
    next_ping_to_schedule.schedule! ((last_ping_at || Time.now) + seconds)
  end

  def next_ping_to_schedule
    pings.first_scheduled || pings.new
  end

  def next_ping_date
    pings.first_scheduled.try :perform_at
  end

end