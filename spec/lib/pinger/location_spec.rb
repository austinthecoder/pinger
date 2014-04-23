require 'spec_helper'

describe Location do
  describe '.find_by_param' do
    before do
      @location = create_location
    end

    context 'when a location exists' do
      it 'returns it' do
        expect(Location.find_by_param(@location.id)).to eq @location
      end
    end

    context 'when a location does not exist' do
      it 'returns nil' do
        expect(Location.find_by_param(3729485)).to be_nil
      end
    end
  end

  describe '#next_ping_time' do
    before do
      Timecop.freeze Time.now
      @location = create_location
      Ping.create!(:location_id => 435879, :perform_at => 3.minutes.from_now, :performed_at => nil)
      Ping.create!(:location_id => @location.id, :perform_at => 2.minutes.ago, :performed_at => 2.minutes.ago)
    end

    after { Timecop.return }

    context "when there's a scheduled ping" do
      it "returns the time the ping is scheduled for" do
        Ping.create!(:location_id => @location.id, :perform_at => 4.minutes.from_now, :performed_at => nil)
        expect(@location.next_ping_time).to eq 4.minutes.from_now
      end
    end

    context "when a ping hasn't been scheduled" do
      it { subject.next_ping_time.should be_nil }
    end
  end

  def create_location(attrs = {})
    Location.create!({
      :title => 'TITLE',
      :seconds => 20,
      :http_method => 'GET',
      :url => 'http://example.com/',
    }.merge(attrs))
  end

  # describe "class methods" do
  #   subject { Location }

  #   describe "schedule_pings!" do
  #     it "schedules a ping for all locations that don't have one scheduled" do
  #       @with_sched = (1..2).map { create(:location).tap &:schedule_ping! }
  #       @without_sched = (1..2).map { create :location }

  #       subject.schedule_pings!

  #       (@with_sched + @without_sched).each do |l|
  #         l.reload.pings.size.should == 1
  #       end
  #     end
  #   end
  # end

  # describe "validations" do
  #   subject { build :location }

  #   it { should be_valid }

  #   it { should_not accept_values_for :seconds, nil, '', 'a' }

  #   it { should_not accept_values_for :url, nil, '', 'x.com', 'xyz', "http://x.com\nh", "h\nhttp://x.com" }
  #   it { should accept_values_for :url, 'http://x.com', 'https://y.net/d' }

  #   it { should_not accept_values_for :http_method, nil, '', 'x' }
  #   it { should accept_values_for :http_method, 'get', 'post', 'GET', 'POST' }

  #   it { should_not accept_values_for :title, nil, '' }
  #   it { should accept_values_for :title, 'foo' }
  # end
end
