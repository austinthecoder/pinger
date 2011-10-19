class AlertsController < ApplicationController

  respond_to :html

  expose :alert

  def create
    current_user.save_alert(alert)
    respond_with alert, :location => alerts_url
  end

end
