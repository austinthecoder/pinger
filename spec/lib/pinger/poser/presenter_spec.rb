require 'spec_helper'

describe Poser::Presenter do
  include ActionView::TestCase::Behavior

  let(:obj) { mock Object }

  subject { described_class.new obj, view }

  it { subject.should be_a(Comparable) }

  describe "render_form_errors" do
    before do
      obj.stub(:errors) { {foo: ["is bad", 'is wrong']} }
      @form_errors = mock(Object)
      subject.stub(:render) do |*args|
        if args == ['shared/form_errors', {errors: ["Is bad", 'Is wrong']}]
          @form_errors
        end
      end
    end

    context "when the object has errors for the given attribute" do
      it "renders the form errors with the errors capitalized" do
        subject.render_form_errors(:foo).should == @form_errors
      end
    end

    context "when the object doesn't have errors for the given attribute" do
      it { subject.render_form_errors(:bar).should be_blank }
    end
  end
end