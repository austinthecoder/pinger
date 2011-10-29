require 'spec_helper'

describe LocationPresenter::Attribute do

  let :location_presenter do
    mock LocationPresenter, location: mock(Location)
  end

  subject { described_class.new location_presenter }

  it { should be_a(Poser::Presenter::Attribute) }

  [:location].each do |method|
    it "delegates #{method} to the email callback presenter" do
      result = mock Object
      args = [mock(Object), mock(Object)]
      location_presenter.should_receive(method).with(*args).and_return(result)
      subject.send(method, *args).should == result
    end
  end

end