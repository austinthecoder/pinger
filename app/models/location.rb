class Location < ActiveRecord::Base

  HTTP_METHODS = %w[GET POST]

  validates :seconds,
    :presence => true,
    :numericality => {:greater_than => 0, :if => lambda { seconds.present? }}
  validates :http_method, :inclusion => HTTP_METHODS
  validates :url, :format => {:with => /\A#{URI.regexp %w(http https)}\z/}
  validates :title, :presence => true

  delegate :to_s, :to => :title

  def pings
    Ping.all_for_location_id id
  end

  def alerts
    Alert.all_for_location self
  end

  def ping_performed!(ping)
    applicable_alerts = alerts.select do |alert|
      pings_scope = pings.order { performed_at.desc }.limit alert.times
      pings_scope.size == alert.times && pings_scope.all? { |p| p.response_status_code != alert.code_is_not }
    end
    applicable_alerts.each &:deliver!
  end

end