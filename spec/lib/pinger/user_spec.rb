require 'spec_helper'

describe User do
  subject { User.new }

  describe "save_location" do
    before { @location = create :location }

    it "saves the location" do
      @location.should_receive :save
      subject.save_location @location
    end

    context "when the location saves" do
      it "schedules a ping for the location" do
        @location.should_receive :schedule_ping!
        subject.save_location @location
      end

      context "when the ping fails to schedule" do
        before { @location.stub(:schedule_ping!) { raise 'error' } }
        it "should not commit the location changes to the database" do
          title = Time.now.to_i.to_s
          @location.title = title
          subject.save_location(@location) rescue nil
          @location.reload.title.should_not == title
        end
      end
    end

    context "when the location doesn't save" do
      before { @location.stub :save }
      it "doesn't schedule a ping for the location" do
        @location.should_not_receive :schedule_ping!
        subject.save_location @location
      end
    end
  end

  describe "save_email_callback" do
    it "saves the email callback" do
      email_callback = mock EmailCallback
      email_callback.should_receive :save
      subject.save_email_callback email_callback
    end
  end

  describe "build_alert_from_params" do
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
          @params = params
          Alert.stub(:build) { |args| @alert if args == attrs }
        end

        it { subject.build_alert_from_params(@params).should == @alert }
      end
    end
  end
end