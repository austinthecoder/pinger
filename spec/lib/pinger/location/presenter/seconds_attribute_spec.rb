require 'spec_helper'

describe Location::Presenter::SecondsAttribute do

  let :location_presenter do
    mock Location::Presenter, :location => mock(Location, :seconds => 34857)
  end

  subject { described_class.new location_presenter }

  its(:to_s) { should == 34857 }

end