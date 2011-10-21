Then /^I should see the pings table:$/ do |expected_table|
  actual_table = table_array('#pings table tr', 'td,th')
  diff_tables!(actual_table, expected_table)
end

Then /^I should see (\d+) pings$/ do |num|
  all("#pings table tbody tr").size.should == num.to_i
end