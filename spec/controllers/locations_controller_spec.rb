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

    context "when ActiveRecord::RecordInvalid is raised" do
      before do
        @location = Location.new
        subject.current_user.stub(:create_location!) { @location.save! }
      end

      it "renders the new template" do
        post :create, @params
        response.should render_template(:new)
      end

      its(:location) { pending; should === @location }
    end
  end

  describe "member actions" do
    before do
      @location = Factory(:location)
      @params[:id] = @location.id.to_s
    end

    [[:get, :show], [:put, :update]].each do |http_method, action|
      describe "#{http_method.upcase} #{action}" do
        context "when a location doesn't exist for the id in the params" do
          before { @params[:id] = (@location.id + 1).to_s }
          it "raises an error" do
            pending
            lambda do
              send(http_method, action, @params)
            end.should raise_error(ActiveRecord::RecordNotFound)
          end
        end
      end
    end

    describe "GET show" do
      # see above
      context "when a location doesn't exist for the id in the params"
    end

    describe "PUT update" do
      context "when a location exists for the id in the params" do
        it "tells the location to update the attributes" do
          @params[:location] = {:title => 'asdfasdf', :seconds => '22352'}
          subject.location.should_receive(:update_attributes!).with(@params[:location])
          put :update, @params
        end

        it "redirects to the show page" do
          put :update, @params
          response.should redirect_to(location_url(@location))
        end

        context "when ActiveRecord::RecordInvalid is raised" do
          before do
            subject.location.stub(:update_attributes!) do
              raise ActiveRecord::RecordInvalid, @location
            end
          end
          it "renders the edit template" do
            put :update, @params
            response.should render_template(:edit)
          end
        end
      end

      # see above
      context "when a location doesn't exist for the id in the params"
    end

    describe "DELETE destroy" do
      it "destroys the location" do
        delete :destroy, @params
        lambda { @location.reload }.should raise_error(ActiveRecord::RecordNotFound)
      end

      it "redirects to the locations url" do
        delete :destroy, @params
        response.should redirect_to(locations_url)
      end
    end
  end

end
