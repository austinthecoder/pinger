require 'spec_helper'

describe LocationPresenter::Seconds do

  let :location_presenter do
    mock LocationPresenter, :location => mock(Location, :seconds => 34857)
  end

  subject { described_class.new location_presenter }

  its(:to_s) { should == 34857 }

end