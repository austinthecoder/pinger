require 'spec_helper'

describe AlertPresenter do
  subject { described_class.new alert, view }

  let(:alert) { mock Alert, code_is_not: '400', times: 23 }

  describe "location_options_for_select" do
    context "when the template has locations" do
      before do
        view.stub :locations do
          [
            mock(Location, id: 1, title: 'A'),
            mock(Location, id: 2, title: 'B'),
            mock(Location, id: 3, title: 'C')
          ]
        end
      end
      it "returns the locations as arrays of id and title" do
        subject.location_options_for_select.should == [['A', 1], ['B', 2], ['C', 3]]
      end
    end

    context "when there are no locations" do
      before { view.stub(:locations) { [] } }
      its(:location_options_for_select) { should be_empty }
    end
  end

  describe "email_callback_options_for_select" do
    context "when there are email callbacks" do
      before do
        @locs = [[685, 'C'], [345, 'A'], [578, 'B']].map do |id, label|
          create :email_callback, id: id, label: label
        end
      end
      it "returns an array of label and id, ordered by label" do
        subject.email_callback_options_for_select.should == [['A', 345], ['B', 578], ['C', 685]]
      end
    end

    context "when there are no email callbacks" do
      its(:email_callback_options_for_select) { should be_empty }
    end
  end

  describe "for_url" do
    context "when the alert has a location" do
      before { alert.stub(:location) { mock Location, title: 'aoigjasdnfk' } }
      it "returns the alert's location's title" do
        subject.for_url.should == 'aoigjasdnfk'
      end
    end

    context "when the alert doesn't have a location" do
      before { alert.stub :location }
      its(:for_url) { should be_blank }
    end
  end

  describe "alert_via" do
    context "when the alert has an email callback" do
      before { alert.stub(:email_callback) { mock EmailCallback, label: 'irnuayksh' } }
      it "returns the email callback's label" do
        subject.alert_via.should == 'irnuayksh'
      end
    end

    context "when the alert doesn't have an email callback" do
      before { alert.stub :email_callback }
      its(:alert_via) { should be_blank }
    end
  end

  %w(code_is_not times).each do |method|
    describe "#{method}" do
      it "delegates to the alert" do
        subject.send(method).should === alert.send(method)
      end
    end
  end

  %w(code_is_not times).each do |name|
    describe "#{name}_errors" do
      it "renders form errors for the alerts's #{name}" do
        form_errors = mock(Object)
        subject.stub(:render_form_errors) { |a| form_errors if a == name }

        subject.send("#{name}_errors").should == form_errors
      end
    end
  end
end