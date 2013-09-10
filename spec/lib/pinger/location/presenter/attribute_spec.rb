require 'spec_helper'

describe Location::Presenter::Attribute do

  let :location_presenter do
    double 'Location::Presenter', location: double('Location')
  end

  subject { described_class.new location_presenter }

  it { should be_a(Poser::Presenter::Attribute) }

  [:location].each do |method|
    it "delegates #{method} to the email callback presenter" do
      result = double 'Object'
      args = [double('Object'), double('Object')]
      location_presenter.should_receive(method).with(*args).and_return(result)
      subject.send(method, *args).should == result
    end
  end

end