require 'spec_helper'

describe LocationPresenter::HttpMethod do

  let :location_presenter do
    mock LocationPresenter, :location => mock(Location, :http_method => 'SFJLSFJ')
  end

  subject { described_class.new location_presenter }

  its(:to_s) { should == 'SFJLSFJ' }

end