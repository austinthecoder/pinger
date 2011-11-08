require 'spec_helper'

describe Ping, "class methods" do
  subject { described_class }

  describe "first_scheduled" do
    it "returns the first ping that hasn't been performed" do
      create :ping, performed_at: Time.now
      p = create :ping, performed_at: nil
      create :ping, performed_at: nil

      subject.first_scheduled.should == p
    end
  end

  describe "performed" do
    it "returns the pings that have been performed" do
      ps = [
        create(:ping, performed_at: Time.now),
        create(:ping, performed_at: Time.now)
      ]
      create :ping, performed_at: nil

      subject.performed.should == ps
    end
  end
end