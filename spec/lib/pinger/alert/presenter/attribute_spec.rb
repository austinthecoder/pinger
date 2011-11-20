require 'spec_helper'

describe Alert::Presenter::Attribute do

  let :alert_presenter do
    mock Alert::Presenter, alert: mock(Alert)
  end

  subject { described_class.new alert_presenter }

  it { should be_a(Poser::Presenter::Attribute) }

  [:alert].each do |method|
    it "delegates #{method} to the alert presenter" do
      result = mock Object
      args = [mock(Object), mock(Object)]
      alert_presenter.should_receive(method).with(*args).and_return(result)
      subject.send(method, *args).should == result
    end
  end

end