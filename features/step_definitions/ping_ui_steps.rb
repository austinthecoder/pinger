Then /^I should see the pings table:$/ do |expected_table|
  actual_table = tableish('#pings table tr', 'td,th')
  diff_tables!(actual_table, expected_table)
end