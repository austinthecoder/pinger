require 'spec_helper'

describe ApplicationHelper do

  subject { helper }

  describe "render_main_menu" do
    context "when there are locations" do
      before { helper.stub(:locations) { [mock(Location)] } }
      it "should render the main menu as piped links" do
        helper.should_receive(:render_piped_links).with [
          ["Add URL", new_location_path],
          ["Add email callback", new_email_callback_path],
          ["Add alert", new_alert_path]
        ]
        helper.render_main_menu
      end
    end

    context "when there are no locations" do
      before { helper.stub(:locations) }
      it "should render the main menu, without the 'Add alert' item, as piped links" do
        helper.should_receive(:render_piped_links).with [
          ["Add URL", new_location_path],
          ["Add email callback", new_email_callback_path]
        ]
        helper.render_main_menu
      end
    end
  end

  describe "render_piped_links" do
    context "with link args" do
      before { @link_args = [['a', '/'], ['b', '/foo']] }

      it "returns links delimited by pipes" do
        helper.render_piped_links(@link_args).should == "#{helper.link_to('a', '/')} | #{helper.link_to('b', '/foo')}"
      end

      it("is html safe") { helper.render_piped_links(@link_args).should be_html_safe }
    end
  end

end
