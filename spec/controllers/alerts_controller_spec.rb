require 'spec_helper'

describe AlertsController do

  describe "POST create" do
    before { controller.stub(:respond_with) { controller.render :text => '' } }

    it "tells the user to save the alert" do
      controller.current_user.should_receive(:save_alert).with(controller.alert)
      post :create
    end

    it "tells the controller to respond with the alert" do
      controller.should_receive(:respond_with).with controller.alert,
        :location => alerts_url
      post :create
    end
  end

end
