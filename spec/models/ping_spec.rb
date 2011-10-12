require 'spec_helper'

describe Ping do

  subject { Factory.build(:ping) }

  describe "schedule!" do
    before do
      @location = subject.location
      @location.seconds = 3.minutes
    end

    context "when the location doesn't have any performed pings" do
      it "sets perform_at equal to the locations seconds into the future" do
        Timecop.freeze(Time.now) do
          subject.schedule!
          subject.reload.perform_at.to_i.should == 3.minutes.from_now.to_i
        end
      end
    end

    context "when the location has performed pings" do
      before do
        (1..2).map { |i| @location.pings.create!(:performed_at => i.minutes.ago) }
      end
      it "sets perform_at equal to the date the last ping was performed plus the location seconds" do
        Timecop.freeze(Time.now) do
          subject.schedule!
          subject.reload.perform_at.to_i.should == 2.minutes.from_now.to_i
        end
      end
    end

    it "schedules the ping to be performed at the perform_at date" do
      subject.schedule!
      Ping.should have_scheduled_at(subject.perform_at, subject.id)
    end
  end

  describe "validations" do
    subject { Factory.build(:ping) }

    it { should be_valid }

    it { should_not accept_values_for(:location_id, nil) }
  end

end
