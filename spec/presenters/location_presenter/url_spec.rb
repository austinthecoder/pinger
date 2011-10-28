require 'spec_helper'

describe LocationPresenter::Url do

  let :location_presenter do
    mock LocationPresenter, :location => mock(Location, :url => 'http://google.com')
  end

  subject { described_class.new location_presenter }

  its(:to_s) { should == 'http://google.com' }

end