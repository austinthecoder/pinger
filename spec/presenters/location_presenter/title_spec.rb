require 'spec_helper'

describe LocationPresenter::Title do

  let :location_presenter do
    mock LocationPresenter, :location => mock(Location, :title => 'Abc')
  end

  subject { described_class.new location_presenter }

  its(:to_s) { should == 'Abc' }

end