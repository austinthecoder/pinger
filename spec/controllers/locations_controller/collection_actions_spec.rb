require 'spec_helper'

describe LocationsController, "collection actions" do
  subject { controller }

  before { @params = HashWithIndifferentAccess.new }

  describe "POST create" do
    before do
      @location = build :location
      subject.stub(:location) { @location }
    end

    it "tells the location to save and schedule a ping" do
      subject.location.should_receive :save_and_schedule_ping!
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