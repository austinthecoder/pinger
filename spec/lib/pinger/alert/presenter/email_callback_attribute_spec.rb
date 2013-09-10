require 'spec_helper'

describe Alert::Presenter::EmailCallbackAttribute do

  let :alert_presenter do
    double 'Alert::Presenter', alert: double('Alert')
  end

  subject { described_class.new alert_presenter }

  it { should be_a(Alert::Presenter::Attribute) }

  [:email_callback_options_for_select].each do |method|
    it "delegates #{method} to the alert presenter" do
      result = double 'Object'
      args = [double('Object'), double('Object')]
      alert_presenter.should_receive(method).with(*args).and_return(result)
      subject.send(method, *args).should == result
    end
  end

end