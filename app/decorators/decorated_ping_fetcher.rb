module DecoratedPingFetcher

  attr_accessor :location
  attr_accessor :controller

  def new_ping(attrs = {})
    decorate_ping(new).tap do |ping|
      ping.attributes = attrs
    end
  end

  def first_scheduled
    if ping = scheduled.first
      decorate_ping ping
    end
  end

  def each
    super do |object|
      yield decorate_ping(object)
    end
  end

private

  def decorate_ping(ping)
    ping.extend(DecoratedPing).tap do |ping|
      ping.controller = controller
    end
  end

end