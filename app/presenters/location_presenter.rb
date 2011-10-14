class LocationPresenter < BasePresenter

  presents :location

  delegate :url, :seconds, :to => :location

  def next_ping
    now = Time.now
    if location.next_ping_date && location.next_ping_date > now
      tpl.distance_of_time_in_words(now, location.next_ping_date)
    else
      'just a moment'
    end
  end

  def http_method
    location.http_method.upcase
  end

  def pings
    @pings ||= begin
      pings = location.pings.where { performed_at.not_eq(nil) }.order { performed_at.desc }
      pings.map { |p| PingPresenter.new(p, tpl) }
    end
  end

end