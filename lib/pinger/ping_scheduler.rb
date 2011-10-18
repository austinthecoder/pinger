class PingScheduler
  @queue = :low

  class << self
    def perform(*args)
      Location.schedule_pings!
    end
  end
end