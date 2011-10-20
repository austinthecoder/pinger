require 'spec_helper'

describe AlertPresenter do
  subject { described_class.new(alert, view) }

  let(:alert) { mock(Alert) }

  describe "location_options_for_select" do
    context "when the template has locations" do
      before do
        view.stub(:locations) do
          [
            mock(Location, :id => 1, :title => 'A'),
            mock(Location, :id => 2, :title => 'B'),
            mock(Location, :id => 3, :title => 'C')
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
          Factory(:email_callback, :id => id, :label => label)
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
end