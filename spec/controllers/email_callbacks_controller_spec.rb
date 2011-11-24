require 'spec_helper'

describe EmailCallbacksController do

  describe "POST create" do
    before { controller.stub(:respond_with) { controller.render text: '' } }

    it "tells the email callback to save" do
      controller.email_callback.should_receive(:save)
      post :create
    end

    it "tells the controller to respond with the email callback" do
      controller.should_receive(:respond_with).with controller.email_callback,
        location: email_callbacks_url
      post :create
    end
  end

  describe "member actions" do
    before do
      @params = HashWithIndifferentAccess.new
      @email_callback = create :email_callback
      @params[:id] = @email_callback.id.to_s
      subject.stub(:email_callback) { @email_callback }
    end

    describe "PUT update" do
      it "updates the attributes from the params" do
        @params[:email_callback] = {label: 'foo', to: 'x@y.com'}
        @email_callback.should_receive(:attributes=).with @params[:email_callback]
        put :update, @params
      end

      it "tells the email callback to save" do
        subject.email_callback.should_receive(:save)
        put :update, @params
      end

      it "redirects to the index page" do
        put :update, @params
        response.should redirect_to(email_callbacks_url)
      end

      context "when the email callback doesn't get saved" do
        before { @params[:email_callback] = {label: ''} }
        it "renders the edit template" do
          put :update, @params
          response.should render_template(:edit)
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the email callback" do
        delete :destroy, @params
        EmailCallback.find_by_id(@email_callback.id).should be_nil
      end

      it "redirects to the email callbacks url" do
        delete :destroy, @params
        response.should redirect_to(email_callbacks_url)
      end
    end
  end

end
