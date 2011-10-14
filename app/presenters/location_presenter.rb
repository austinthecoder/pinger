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
    @pings ||= location.pings.where { performed_at.not_eq(nil) }.order { performed_at.desc }
  end

  def render_pings
    if pings.present?
      tpl.render 'pings/table', :pings => pings
    else
      tpl.content_tag :p, 'No pings yet'
    end
  end

end