require 'spec_helper'

describe Ping::Presenter do
  include ActionView::TestCase::Behavior
  include RSpec::Rails::Matchers::RenderTemplate

  subject { described_class.new ping, view }

  let :ping do
    create :ping,
      response_status_code: 200,
      performed_at: Time.parse('2011-01-15 12:14:37 UTC')
  end

  describe "response_status_code" do
    it "delegates to the ping" do
      subject.response_status_code.should === 200
    end
  end

  describe "date" do
    it "returns the performed_at date formatted" do
      subject.date.should == "Jan 15, 2011 at 12:14:37 PM UTC"
    end
  end
end