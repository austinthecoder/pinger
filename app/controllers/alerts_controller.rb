class AlertsController < ApplicationController

  respond_to :html

  helper_method :alert

  def create
    alert.save
    respond_with alert, location: alerts_url
  end

##################################################

  # TODO: test
  def alert
    @alert ||= begin
      attrs = params[:alert] || {}
      attrs[:location_id] = params[:location_id] if params[:location_id].present?
      Alert.new attrs
    end
  end

end
