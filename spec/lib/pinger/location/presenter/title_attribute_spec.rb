require 'spec_helper'

describe Location::Presenter::TitleAttribute do

  let :location_presenter do
    mock Location::Presenter, :location => mock(Location, :title => 'Abc')
  end

  subject { described_class.new location_presenter }

  its(:to_s) { should == 'Abc' }

end