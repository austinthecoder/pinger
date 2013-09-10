require 'spec_helper'

describe Location::Presenter::HttpMethodAttribute do

  let :location_presenter do
    double 'Location::Presenter', :location => double('Location', :http_method => 'SFJLSFJ')
  end

  subject { described_class.new location_presenter }

  its(:to_s) { should == 'SFJLSFJ' }

end