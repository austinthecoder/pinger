module DecoratedLocation

  attr_accessor :account
  attr_accessor :controller

  def add
    account.add_location self
  end

  def modify(attrs = {})
    account.modify_location self, attrs
  end

  def path
    controller.location_path self
  end

  [:edit, :delete].each do |name|
    define_method "#{name}_path" do
      controller.send "#{name}_location_path", self
    end
  end

  def new_alert_path
    controller.new_location_alert_path self
  end

  def scheduled_ping
    @scheduled_ping ||= ping_fetcher.first_scheduled
  end

  def schedule_ping!
    ping = new_ping :perform_at => (Time.zone.now + seconds)
    ping.save!
    Resque.enqueue_at ping.perform_at, Ping, ping.id
  end

  def ping_fetcher
    @ping_fetcher ||= pings.extend(DecoratedPingFetcher).tap do |pings|
      pings.controller = controller
      pings.location = self
    end
  end

  def save_and_schedule_ping!
    ActiveRecord::Base.transaction do
      save && schedule_ping!
    end
  end

private

  delegate :new_ping, :to => :ping_fetcher

end