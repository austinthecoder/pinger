class PingScheduler
  @queue = :low

  class << self
    # TODO: test
    def perform(*args)
      Location.all.reject { |l| l.pings.scheduled.any? }.each &:schedule_ping!
    end
  end
end