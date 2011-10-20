class PingPresenter < BasePresenter

  presents :ping

  delegate :response_status_code, :to => :ping

  def date
    ping.performed_at.strftime "%b %e, %Y at %l:%M:%S %p %Z"
  end

end