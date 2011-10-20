class PingScheduler
  @queue = :low

  class << self
    # TODO: test
    def perform(*args)
      Location.schedule_pings!
    end
  end
end