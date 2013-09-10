Then /^I should see the pings table:$/ do |expected_table|
  actual_table = table_array '#pings table tr', 'td,th'
  diff_tables! actual_table, expected_table
end

Then /^I should see (\d+) pings$/ do |num|
  all("#pings table tbody tr").size.should == num.to_i
end

Then /^I should that no pings have been performed$/ do
  all("#pings .ping").size.should == 0
end

Then /^I should (\d+) pings were performed$/ do |num|
  all("#pings .ping").size.should == num.to_i
end

Then /^I should see 1 ping was performed (\d+) minutes ago$/ do |mins|
  date = mins.to_i.minutes.ago
  all("#pings .ping").size.should == 1
  within "#pings .ping" do
    page.should have_content(date.strftime("%b %-d, %Y at %l:%M:%S %p %Z"))
  end
end

Then /^I should see a ping is scheduled for (\d+) minutes from now$/ do |mins|
  date = mins.to_i.minutes.from_now
  within "#pings #next" do
    page.should have_content(date.strftime("%b %-d, %Y at %l:%M:%S %p %Z"))
  end
end

Then /^I should see the newest ping was just performed$/ do
  all("#pings .ping")[0].should have_content(Time.zone.now.strftime("%b %-d, %Y at %l:%M:%S %p %Z"))
end

Then /^I should see the oldest ping was performed (\d+) minutes ago$/ do |mins|
  date = mins.to_i.minutes.ago
  all("#pings .ping")[-1].should have_content(date.strftime("%b %-d, %Y at %l:%M:%S %p %Z"))
end