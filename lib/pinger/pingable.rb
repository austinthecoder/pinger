module Pingable
  extend ActiveSupport::Concern

  included do
    has_many :pings

    class << self
      # if there's no scheduled pings, schedule one
      def schedule_pings!
        all.each { |l| l.schedule_ping! unless l.pings.first_scheduled }
      end
    end
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