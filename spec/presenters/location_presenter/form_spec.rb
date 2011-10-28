require 'spec_helper'

shared_examples 'a form presenter' do
  [:label, :text_field, :select].each do |method|
    describe "#{method}" do
      it "delegates to the form builder" do
        form_builder.stub(method) { method }
        subject.send(method).should == method
      end
    end
  end

  [:render, :button_tag].each do |method|
    describe "#{method}" do
      it "delegates to the object presenter" do
        object_presenter.stub(method) { method }
        subject.send(method).should == method
      end
    end
  end
end

describe LocationPresenter::Form do
  let :location do
    mock Location
  end

  let :location_presenter do
    LocationPresenter.new location, view
  end

  let :form_builder do
    mock Object,
      label: :label,
      text_field: :text_field,
      select: :select
  end

  subject do
    described_class.new location_presenter, form_builder
  end

  it_behaves_like 'a form presenter' do
    let :object_presenter do
      location_presenter
    end
  end

  [
    ['title', described_class::TitleInput],
    ['url', described_class::UrlInput],
    ['http_method', described_class::HttpMethodInput],
    ['seconds', described_class::SecondsInput]
  ].each do |method, klass|
    describe "#{method}" do
      it "returns a #{method.gsub /_/, ' '} input" do
        subject.send(method).should == klass.new(subject)
      end
    end
  end

end