require 'spec_helper'

describe Poser::Presenter::Attribute do

  let(:presenter) { double 'Poser::Presenter' }

  subject { described_class.new presenter }

  its(:presenter) { should == presenter }

  it { should be_a(Comparable) }

  describe "<=>" do
    it "returns the comparison of the presenter and the other objects presenter" do
      result = double 'Object'
      other_subject = double 'Object', presenter: double('Object')
      presenter.should_receive(:<=>).with(other_subject.presenter).and_return(result)
      (subject <=> other_subject).should == result
    end
  end

  [:form_builder, :render].each do |method|
    it "delegates #{method} to the presenter" do
      result = double('Object')
      args = [double('Object'), double('Object')]
      presenter.should_receive(method).with(*args).and_return(result)
      subject.send(method, *args).should == result
    end
  end

  [:text_field, :select].each do |method|
    it "delegates #{method} to the form builder" do
      form_builder = double 'Object'
      subject.stub(:form_builder) { form_builder }
      result = double('Object')
      args = [double('Object'), double('Object')]
      form_builder.should_receive(method).with(*args).and_return(result)
      subject.send(method, *args).should == result
    end
  end

end