require 'spec_helper'

describe LocationsController do

  before do
    @params = HashWithIndifferentAccess.new
  end

  describe "GET new" do
    it "assigns a new location" do
      get :new
      assigns(:location).should be_a(Location)
      assigns(:location).should be_new_record
    end
  end

  describe "POST create" do
    before do
      @location = mock(Location, :id => 5)
      controller.current_user.stub(:create_location!) { @location }
    end

    it "passes the location params to current_user#create_location!" do
      @params[:location] = HashWithIndifferentAccess.new(
        :url => 'http://x.com',
        :http_method => 'GET',
        :seconds => '10'
      )

      controller.current_user.should_receive(:create_location!).with(@params[:location])

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
        get :show, :id => @location.id.to_s
        assigns(:location).should == @location
      end
    end

    context "when a location doesn't exist for the id in the params" do
      it "raises an error" do
        lambda do
          get :show, :id => (@location.id + 1).to_s
        end.should raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "POST schedule_pings" do
    it "calls Location.schedule_pings!" do
      Location.should_receive(:schedule_pings!)
      post :schedule_pings
      response.code.should == "200"
    end
  end

end
