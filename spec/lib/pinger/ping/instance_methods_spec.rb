require 'spec_helper'

describe Ping, "instance methods" do

  subject { build :ping }

  it("is valid with valid attributes") { should be_valid }

  it { should_not accept_values_for :location_id, nil }

  describe "schedule!", freeze_time: true do
    it "sets perform_at" do
      subject.schedule! 4.minutes.from_now
      subject.reload.perform_at.should == 4.minutes.from_now
    end

    it "schedules the ping to be performed" do
      subject.schedule! 5.minutes.from_now
      described_class.should have_scheduled_at 5.minutes.from_now, subject.id
    end
  end

  describe "perform!" do
    before do
      subject.stub :deliver_applicable_alerts!
      subject.location.stub(:perform_request) { mock Object, code: '234' }
    end

    it "tells the location to perform the request" do
      subject.location.should_receive :perform_request
      subject.perform!
    end

    it "persists the response status code" do
      subject.perform!
      subject.reload.response_status_code = '234'
    end

    it "persists the time", freeze_time: true do
      subject.perform!
      subject.reload.performed_at.should == Time.now
    end

    it "delivers the applicable alerts" do
      subject.should_receive :deliver_applicable_alerts!
      subject.perform!
    end

    context "when performing the request fails" do
      before { subject.location.stub(:perform_request) { raise 'error' } }

      it "should still persist the time", freeze_time: true do
        subject.perform! rescue nil
        subject.reload.performed_at.should == Time.now
      end

      it "should not deliver alerts" do
        subject.should_not_receive :deliver_applicable_alerts!
        subject.perform! rescue nil
      end
    end

    context "when delivering the alerts fails" do
      before { subject.stub(:deliver_applicable_alerts!) { raise 'error' } }
      it "should still persist the time", freeze_time: true do
        subject.perform! rescue nil
        subject.reload.performed_at.should == Time.now
      end
    end
  end

  describe "deliver_applicable_alerts!" do
    it "tells the alerts, that have the conditions met, to deliver" do
      alerts = [
        mock(Alert, :conditions_met? => true),
        mock(Alert, :conditions_met? => false)
      ]
      subject.stub(:alerts) { alerts }
      alerts[0].should_receive :deliver!
      alerts[1].should_not_receive :deliver!
      subject.deliver_applicable_alerts!
    end
  end

end
