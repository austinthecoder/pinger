require 'spec_helper'

describe Ping do

  subject { Factory.build(:ping) }

  describe "schedule!" do
    before { Timecop.freeze(Time.now) }
    after { Timecop.return }

    it "sets perform_at" do
      subject.schedule!(4.minutes.from_now)
      subject.reload.perform_at.should == 4.minutes.from_now
    end

    it "schedules the ping to be performed" do
      subject.schedule!(5.minutes.from_now)
      Ping.should have_scheduled_at(5.minutes.from_now, subject.id)
    end
  end

  describe "perform!" do
    it "delivers the applicable alerts" do
      pending
      subject.should_receive(:deliver_applicable_alerts!)
      subject.perform!
    end
  end

  describe "deliver_applicable_alerts!" do
    it "tells the alerts, that have the conditions met, to deliver" do
      alerts = [
        mock(Alert, :conditions_met? => true),
        mock(Alert, :conditions_met? => false)
      ]
      subject.stub(:alerts) { alerts }
      alerts[0].should_receive(:deliver!)
      alerts[1].should_not_receive(:deliver!)
      subject.deliver_applicable_alerts!
    end
  end

  describe "validations" do
    subject { Factory.build(:ping) }

    it { should be_valid }

    it { should_not accept_values_for(:location_id, nil) }
  end

end
