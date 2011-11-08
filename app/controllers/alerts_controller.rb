class AlertsController < ApplicationController

  respond_to :html

  helper_method :alert

  def create
    current_user.save_alert alert
    respond_with alert, location: alerts_url
  end

  # TODO: test
  def alert
    @alert ||= begin
      alert_attrs = params[:alert] || {}
      alert_attrs.reverse_merge! :location_id => params[:location_id]
      Alert.new alert_attrs
    end
  end

end
