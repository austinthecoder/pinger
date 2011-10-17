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

  describe "validations" do
    subject { Factory.build(:ping) }

    it { should be_valid }

    it { should_not accept_values_for(:location_id, nil) }
  end

end
