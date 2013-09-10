require 'spec_helper'

describe Location::Presenter::UrlAttribute do

  let :location_presenter do
    double 'Location::Presenter', :location => double('Location', :url => 'http://google.com')
  end

  subject { described_class.new location_presenter }

  its(:to_s) { should == 'http://google.com' }

end