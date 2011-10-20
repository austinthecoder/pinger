require 'spec_helper'

describe Location do

  describe "class methods" do
    subject { Location }

    describe "schedule_pings!" do
      it "schedules a ping for all locations that don't have one scheduled" do
        @with_sched = (1..2).map { Factory(:location).tap &:schedule_ping! }
        @without_sched = (1..2).map { Factory :location }

        subject.schedule_pings!

        (@with_sched + @without_sched).each do |l|
          l.reload.pings.size.should == 1
        end
      end
    end
  end

  describe "validations" do
    subject { Factory.build :location }

    it { should be_valid }

    it { should_not accept_values_for :seconds, nil, '', 'a' }

    it { should_not accept_values_for :url, nil, '', 'x.com', 'xyz', "http://x.com\nh", "h\nhttp://x.com" }
    it { should accept_values_for :url, 'http://x.com', 'https://y.net/d' }

    it { should_not accept_values_for :http_method, nil, '', 'x' }
    it { should accept_values_for :http_method, 'get', 'post', 'GET', 'POST' }

    it { should_not accept_values_for :title, nil, '' }
    it { should accept_values_for :title, 'foo' }
  end

end
