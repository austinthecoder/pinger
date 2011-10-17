require 'spec_helper'

describe LocationsController, "member actions" do
  subject { controller }

  before do
    @params = HashWithIndifferentAccess.new
    @location = Factory(:location)
    @params[:id] = @location.id.to_s
    subject.stub(:location) { @location }
  end

  describe "PUT update" do
    it "updates the attributes from the params" do
      @params[:location] = {:title => 'foo', :seconds => '2345'}
      @location.should_receive(:attributes=).with(@params[:location])
      put :update, @params
    end

    it "tells the current_user to save the location" do
      subject.current_user.should_receive(:save_location).with(@location)
      put :update, @params
    end

    it "redirects to the show page" do
      put :update, @params
      response.should redirect_to(location_url(@location))
    end

    context "when the location doesn't get saved" do
      before { @params[:location] = {:title => ''} }
      it "renders the edit template" do
        put :update, @params
        response.should render_template(:edit)
      end
    end
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