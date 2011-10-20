require 'spec_helper'

describe User do
  subject { User.new }

  describe "save_location" do
    before { @location = Factory :location }

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

  describe "save_alert" do
    it "saves the email callback" do
      alert = mock Alert
      alert.should_receive :save
      subject.save_alert alert
    end
  end
end