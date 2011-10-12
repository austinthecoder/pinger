require 'spec_helper'

describe User do

  subject { User.new }

  describe "create_location!" do
    before do
      @location = Factory(:location, :seconds => 180)
      Location.stub(:create!) { @location }
    end

    it "passes the attributes to Location.create!" do
      attrs = {:a => 1, :b => 2}
      Location.should_receive(:create!).with(attrs)
      subject.create_location!(attrs)
    end

    it "creates a ping for the location" do
      lambda do
        subject.create_location!
      end.should change { @location.reload.pings.size }.by(1)
    end

    it "schedules the ping to be performed" do
      Timecop.freeze(Time.now) do
        subject.create_location!
        Ping.should have_scheduled_at(3.minutes.from_now, Ping.last.id)
      end
    end

    it "returns the location" do
      subject.create_location!.should == @location
    end

    context "without attributes" do
      it "passes an empty hash to Location.create!" do
        Location.should_receive(:create!).with({})
        subject.create_location!
      end
    end
  end

end