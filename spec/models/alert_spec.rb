require 'spec_helper'

describe Alert do

  subject do
    build :alert,
      :email_callback => email_callback,
      :location => create(:location),
      :times => 3,
      :code_is_not => '200'
  end

  let(:email_callback) { build :email_callback }

  describe "conditions_met?" do
    context "when the location's last N pings have the wrong code, where N is the times" do
      before do
        3.times do |i|
          create :ping,
            :location => subject.location,
            :response_status_code => (subject.code_is_not + '1')
        end
      end
      it { should be_conditions_met }
    end

    context "when at least 1 of the location's last N pings have the correct code, where N is the times" do
      before do
        2.times do |i|
          create :ping,
            :location => subject.location,
            :response_status_code => (subject.code_is_not + '1')
        end
        create :ping,
          :location => subject.location,
          :response_status_code => subject.code_is_not
      end
      it { should_not be_conditions_met }
    end
  end

  describe "deliver!" do
    it "tells a notification email to deliver" do
      notif = mock Mail::Message, :deliver => nil
      AlertMailer.stub(:notification) { |a| notif if a == subject }

      notif.should_receive :deliver
      subject.deliver!
    end
  end

  describe "validations" do
    subject { build :alert }

    it { should accept_values_for(:times, 1) }
    it { should_not accept_values_for(:times, nil, 0, '', 'a') }

    it { should accept_values_for(:code_is_not, '200') }
    it { should_not accept_values_for(:code_is_not, nil, '') }
  end

end
