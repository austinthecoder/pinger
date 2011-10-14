require 'spec_helper'

describe LocationsController do

  subject { controller }

  before { @params = HashWithIndifferentAccess.new }

  describe "location" do
    context "when the params contains an id" do
      before { subject.params[:id] = 95347 }

      context "when a location exists for that id" do
        before { @location = Factory(:location, :id => 95347) }
        its(:location) { should == @location }
      end

      context "when a location doesn't exists for that id" do
        it { lambda { subject.location }.should raise_error(ActiveRecord::RecordNotFound) }
      end
    end

    context "when the params doesn't contain an id" do
      its(:location) { should be_a(Location) }
      its(:location) { should be_new_record }
    end
  end

  describe "locations" do
    it "returns the locations, newest first" do
      Timecop.freeze(Time.now) do
        locations = [
          Factory(:location, :id => 3000, :created_at => 2.minutes.ago),
          Factory(:location, :id => 2000, :created_at => 2.minutes.ago),
          Factory(:location, :created_at => 3.minutes.ago)
        ]
        subject.locations.should == locations
      end
    end
  end

  describe "POST create" do
    before do
      @location = Factory(:location)
      subject.current_user.stub(:create_location!) { @location }
    end

    it "tells the current_user to create a location" do
      @params[:location] = HashWithIndifferentAccess.new(
        :url => 'http://x.com',
        :http_method => 'GET',
        :seconds => '10'
      )

      subject.current_user.should_receive(:create_location!).with(@params[:location])

      post :create, @params
    end

    it "redirects to the url for that location" do
      post :create, @params
      response.should redirect_to(location_url(@location))
    end
  end

  describe "GET show" do
    before { @location = Factory(:location) }

    context "when a location exists for the id in the params" do
      it "assigns the location" do
        pending
        get :show, :id => @location.id.to_s
        assigns(:location).should == @location
      end
    end

    context "when a location doesn't exist for the id in the params" do
      it "raises an error" do
        pending
        lambda do
          get :show, :id => (@location.id + 1).to_s
        end.should raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

end
