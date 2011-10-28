require 'spec_helper'

describe LocationPresenter::Attribute do

  let :location_presenter do
    mock LocationPresenter
  end

  subject { described_class.new location_presenter }

  its(:location_presenter) { should == location_presenter }

  [:form_builder, :location, :render].each do |method|
    it "delegates #{method} to the location presenter" do
      result = mock(Object)
      args = [mock(Object), mock(Object)]
      location_presenter.should_receive(method).with(*args).and_return(result)
      subject.send(method, *args).should == result
    end
  end

  [:text_field, :select].each do |method|
    it "delegates #{method} to the form builder" do
      form_builder = mock Object
      subject.stub(:form_builder) { form_builder }
      result = mock(Object)
      args = [mock(Object), mock(Object)]
      form_builder.should_receive(method).with(*args).and_return(result)
      subject.send(method, *args).should == result
    end
  end

end