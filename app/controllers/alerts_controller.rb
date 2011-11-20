class AlertsController < ApplicationController

  respond_to :html

  helper_method :alert

  def create
    alert.save
    respond_with alert, location: alerts_url
  end

  # TODO: test
  def alert
    @alert ||= current_user.build_alert_from_params(params)
  end

end
