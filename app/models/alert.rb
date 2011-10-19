class Alert < ActiveRecord::Base

  belongs_to :location
  belongs_to :email_callback

  def conditions_met?
    pings = location.pings.order { performed_at.desc }.limit(times)
    pings.size == times && pings.all? { |p| p.response_status_code != code_is_not }
  end

  def deliver!
    AlertMailer.notification(self).deliver
  end

end
