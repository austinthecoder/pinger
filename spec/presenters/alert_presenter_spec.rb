require 'spec_helper'

describe AlertPresenter do
  subject { described_class.new(alert, view) }

  let(:alert) { mock(Alert) }

  describe "location_options_for_select" do
    context "when there are locations" do
      before do
        @locs = [[685, 'C'], [345, 'A'], [578, 'B']].map do |id, title|
          Factory(:location, :id => id, :title => title)
        end
      end
      it "returns an array of id and title, ordered by title" do
        subject.location_options_for_select.should == [['A', 345], ['B', 578], ['C', 685]]
      end
    end

    context "when there are no locations" do
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