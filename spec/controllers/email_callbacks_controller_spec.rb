require 'spec_helper'

describe EmailCallbacksController do

  describe "POST create" do
    before { controller.stub(:respond_with) { controller.render :text => '' } }

    it "tells the user to save the email callback" do
      controller.current_user.should_receive(:save_email_callback).with(controller.email_callback)
      post :create
    end

    it "tells the controller to respond with the email callback" do
      controller.should_receive(:respond_with).with controller.email_callback,
        :location => email_callbacks_url
      post :create
    end
  end

end
