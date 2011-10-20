require 'spec_helper'

describe LocationsController, "collection actions" do
  subject { controller }

  before { @params = HashWithIndifferentAccess.new }

  describe "POST create" do
    before do
      @location = Factory.build :location
      subject.stub(:location) { @location }
    end

    it "tells the current_user to save the location" do
      subject.current_user.should_receive(:save_location).with @location
      post :create, @params
    end

    it "redirects to the url for that location" do
      post :create, @params
      response.should redirect_to(location_url @location)
    end

    context "when the location doesn't get saved" do
      before { @location.title = '' }
      it "renders the new template" do
        post :create, @params
        response.should render_template(:new)
      end
    end
  end
end