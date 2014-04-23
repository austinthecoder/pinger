require 'spec_helper'

describe LocationsController do
  before do
    @user = User.new
    controller.stub(:user) { @user }
    @params = {}
  end

  context 'collection actions' do
    before do
      @location = location_double
      @user.stub(:new_location).with('title' => 'TITLE') { @location }
      @params.merge! 'location' => {'title' => 'TITLE'}
    end

    describe 'GET index' do
      before do
        @locations = double 'locations'
        @user.stub(:paginated_locations_ordered_by_title) { @locations }
      end

      it 'assigns the locations' do
        get :index
        expect(assigns(:locations)).to eq @locations
      end

      it 'renders the template' do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET new' do
      it 'assigns a new location' do
        post :create, @params
        expect(assigns :location).to eq @location
      end
    end

    describe "POST create" do
      it 'assigns a new location' do
        post :create, @params
        expect(assigns :location).to eq @location
      end

      it 'saves the location' do
        @location.should_receive :save
        post :create, @params
      end

      it "redirects to the location's URL when it saves" do
        post :create, @params
        expect(response).to redirect_to location_url(@location)
      end

      it 'renders the new template when it does not save' do
        @location.stub :save
        post :create, @params
        expect(response).to render_template 'new'
      end
    end
  end

  context 'member actions' do
    before do
      @location = location_double
      @user.stub(:find_location_by_param).with('PARAM') { @location }
      @params.merge! 'id' => 'PARAM'
    end

    describe 'GET show' do
      it 'assigns the location' do
        get :show, @params
        expect(assigns :location).to eq @location
      end
    end

    describe 'GET edit' do
      it 'assigns the location' do
        get :edit, @params
        expect(assigns :location).to eq @location
      end
    end

    describe "PUT update" do
      before { @params.merge! 'location' => {'title' => 'TITLE'} }

      it 'assigns the location' do
        put :update, @params
        expect(assigns :location).to eq @location
      end

      it "sets the location's attributes from the params" do
        @location.should_receive(:attributes=).with('title' => 'TITLE')
        put :update, @params
      end

      it 'saves the location' do
        @location.should_receive :save
        put :update, @params
      end

      it "redirects to the location's URL when it saves" do
        put :update, @params
        expect(response).to redirect_to location_url(@location)
      end

      it 'renders the edit template when it does not save' do
        @location.stub :save
        put :update, @params
        expect(response).to render_template :edit
      end
    end

    describe "DELETE destroy" do
      it "destroys the location" do
        @location.should_receive :destroy
        delete :destroy, @params
      end

      it "redirects to the locations url" do
        delete :destroy, @params
        response.should redirect_to(locations_url)
      end
    end
  end

  def location_double
    double 'location', :attributes= => nil, :valid? => true, :save => true, :destroy => nil
  end
end