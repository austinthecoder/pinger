require 'spec_helper'

describe Alert::Presenter::LocationAttribute do

  let :alert_presenter do
    mock Alert::Presenter,
      alert: mock(Alert, :location => mock(Location, :title => 'title'))
  end

  subject { described_class.new alert_presenter }

  it { should be_a(Alert::Presenter::Attribute) }

  [:location_options_for_select].each do |method|
    it "delegates #{method} to the alert presenter" do
      result = mock Object
      args = [mock(Object), mock(Object)]
      alert_presenter.should_receive(method).with(*args).and_return(result)
      subject.send(method, *args).should == result
    end
  end

  its(:to_s) { should == "title" }

end