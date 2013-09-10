require 'spec_helper'

describe Location, "instance methods" do
  subject { build :location, seconds: 10.minutes }

  describe "perform_request" do
    it "performs a request" do
      [[:get, "http://x.net"], [:post, "http://y.com"]].each do |http_method, url|
        stub_request http_method, url
        subject.http_method = http_method.to_s
        subject.url = url
        subject.perform_request
        a_request(http_method, url).should have_been_made.once
      end
    end
  end

  describe "http_method=" do
    it "downcases it" do
      [:get, "GET", "get"].each do |m|
        subject.http_method = m
        subject.http_method.should == "get"
      end
    end

    it "sets it to nil if given nil or false" do
      [nil, false].each do |m|
        subject.http_method = m
        subject.http_method.should be_nil
      end
    end
  end

  describe "schedule_ping!", freeze_time: true do
    before do
      subject.save!
      @next_ping = double 'Ping'
      subject.stub(:next_ping_to_schedule) { @next_ping }
      create :ping, performed_at: 1.minute.ago
    end

    context "when pings have been performed" do
      before do
        (2..3).map { |i| create :ping, location: subject, performed_at: i.minutes.ago }
      end
      it "it schedules the next ping to the newest perform date + it's seconds in the future" do
        @next_ping.should_receive(:schedule!).with (2.minutes.ago + 10.minutes)
        subject.schedule_ping!
      end
    end

    context "when a ping has never been performed on the locaiton" do
      it "it schedules the next ping to location's seconds in the future" do
        @next_ping.should_receive(:schedule!).with 10.minutes.from_now
        subject.schedule_ping!
      end
    end
  end

  describe "next_ping_to_schedule" do
    before do
      subject.save!
      create :ping
      create :ping, location: subject, performed_at: 1.minute.ago
    end

    context "when there's a scheduled ping" do
      before { @ping = create :ping, location: subject }
      its(:next_ping_to_schedule) { should == @ping }
    end

    context "when there isn't a scheduled ping" do
      it "should return a new ping for the location" do
        ping = subject.next_ping_to_schedule
        ping.should be_a(Ping)
        ping.should be_new_record
        ping.location.should == subject
      end
    end
  end

  describe "next_ping_date" do
    context "when there's a scheduled ping" do
      before do
        subject.save!
        @ping = subject.pings.create! perform_at: 4.minutes.from_now
      end

      it "returns the date the ping is scheduled for" do
        subject.next_ping_date.to_i.should == @ping.perform_at.to_i
      end
    end

    context "when a ping hasn't been scheduled" do
      it { subject.next_ping_date.should be_nil }
    end
  end
end