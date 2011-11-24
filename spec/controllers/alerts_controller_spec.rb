require 'spec_helper'

describe AlertsController do

  describe "collection actions" do
    subject { controller }

    describe "POST create" do
      before { subject.stub(:respond_with) { subject.render text: '' } }

      it "saves the alert" do
        subject.alert.should_receive(:save)
        post :create
      end

      it "tells the controller to respond with the alert" do
        subject.should_receive(:respond_with).with subject.alert,
          location: alerts_url
        post :create
      end
    end
  end

  describe "instance methods" do
    subject { controller }

    describe "alert" do
      [
        [{:location_id => '234'}, {:location_id => '234'}],
        [{:location_id => ''}, {}],
        [{:location_id => nil}, {}],
        [{}, {}],
        [{:alert => {:foo => 'bar'}}, {:foo => 'bar'}],
        [{:alert => {:foo => 'bar'}, :location_id => 'foo'}, {:foo => 'bar', :location_id => 'foo'}]
      ].each do |params, attrs|
        context "when the params is #{params.inspect}" do
          before do
            @alert = mock(Alert)
            subject.stub(:params) { params }
            Alert.stub(:new) { |args| @alert if args == attrs }
          end

          it { subject.alert.should == @alert }
        end
      end
    end
  end

end
