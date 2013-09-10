require 'spec_helper'

describe Ping, "class methods" do
  subject { described_class }

  describe "scheduled" do
    it "returns pings that haven't been performed" do
      create :ping, :performed_at => Time.now
      result = 2.times.map { create :ping, :performed_at => nil }

      subject.scheduled.should =~ result
    end
  end

  describe "performed" do
    it "returns pings that have been performed" do
      create :ping, :performed_at => nil
      result = 2.times.map { create :ping, :performed_at => Time.now }

      subject.performed.should =~ result
    end
  end

  describe "all_for_location_id" do
    it "returns pings with the given location_id" do
      create :ping, :location_id => 5
      result = 2.times.map { create :ping, :location_id => 4 }

      subject.all_for_location_id(4).should =~ result
    end
  end

  describe "perform" do
    before { stub_request :post, // }

    it "performs the ping with the given id" do
      ping = create :ping, :performed_at => nil
      subject.perform ping.id
      ping.reload.should be_performed
    end
  end
end