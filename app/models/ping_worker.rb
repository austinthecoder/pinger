class PingWorker
  include Sidekiq::Worker

  sidekiq_options :retry => false

  def perform(ping_id)
    Ping.find_by_id(ping_id).try :perform!
  end
end