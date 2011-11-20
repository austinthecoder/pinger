require 'spec_helper'

describe AlertsController do

  describe "POST create" do
    before { controller.stub(:respond_with) { controller.render text: '' } }

    it "saves the alert" do
      controller.alert.should_receive(:save)
      post :create
    end

    it "tells the controller to respond with the alert" do
      controller.should_receive(:respond_with).with controller.alert,
        location: alerts_url
      post :create
    end
  end

end
