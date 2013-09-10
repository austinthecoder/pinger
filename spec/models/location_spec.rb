require 'spec_helper'

describe Location do

  describe "class methods" do
    subject { Location }

    describe "schedule_pings!" do
      it "schedules a ping for all locations that don't have one scheduled" do
        pending
        @with_sched = (1..2).map { create(:location).tap &:schedule_ping! }
        @without_sched = (1..2).map { create :location }

        subject.schedule_pings!

        (@with_sched + @without_sched).each do |l|
          l.reload.pings.size.should == 1
        end
      end
    end
  end

  describe "instance methods" do
    subject { build :location }

    describe "http_method=" do
      it "must be GET or POST" do
        # expect { subject.http_method = }
      end
    end
  end

  describe "validations" do
    subject { Location.new attributes_for(:location) }

    it { should be_valid }

    it { should_not accept_values_for :seconds, nil, '', ' ', 0 }

    it { should_not accept_values_for :url, nil, '', 'x.com', 'xyz', "http://x.com\nh", "h\nhttp://x.com" }
    it { should accept_values_for :url, 'http://x.com', 'https://y.net/d' }

    it { should_not accept_values_for :http_method, nil, '', 'x', 'get', 'post' }
    it { should accept_values_for :http_method, 'GET', 'POST' }

    it { should_not accept_values_for :title, nil, '' }
    it { should accept_values_for :title, 'foo' }
  end

end
