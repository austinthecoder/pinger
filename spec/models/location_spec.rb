require 'spec_helper'

describe Location do

  describe "class methods" do
    subject { Location }

    describe "schedule_pings!" do
      it "schedules a ping for all locations that don't have one scheduled" do
        @with_sched_pings = (1..2).map do
          Factory(:location).tap { |l| l.pings.new.schedule! }
        end
        @without_sched_pings = (1..2).map do
          Factory(:location)
        end

        subject.schedule_pings!

        (@with_sched_pings + @without_sched_pings).each do |l|
          l.reload.pings.size.should == 1
        end
      end
    end
  end

  describe "instance methods" do
    subject { Factory.build(:location) }

    describe "next_ping_date" do
      context "when there's a scheduled ping" do
        before do
          subject.save!
          @ping = subject.pings.create!(:perform_at => 4.minutes.from_now)
        end

        it "returns the date the ping is scheduled for" do
          subject.next_ping_date.to_i.should == @ping.perform_at.to_i
        end
      end

      context "when a ping hasn't been scheduled" do
        it { subject.next_ping_date.should be_nil }
      end
    end

    describe "request" do
      it "performs a request" do
        [[:get, "http://x.net"], [:post, "http://y.com"]].each do |http_method, url|
          stub_request(http_method, url)
          subject.http_method = http_method.to_s
          subject.url = url
          subject.request
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
  end

  describe "validations" do
    subject { Factory.build(:location) }

    it { should be_valid }

    it { should_not accept_values_for(:seconds, nil, '', 'a') }

    it { should_not accept_values_for(:url, nil, '', 'x.com', 'xyz') }
    it { should accept_values_for(:url, 'http://x.com', 'https://y.net/d') }

    it { should_not accept_values_for(:http_method, nil, '', 'x') }
    it { should accept_values_for(:http_method, 'get', 'post', 'GET', 'POST') }

    it { should_not accept_values_for(:title, nil, '') }
    it { should accept_values_for(:title, 'foo') }
  end

end
