def add_url(fields = {})
  fields.reverse_merge!(
    'Title' => 'Page',
    'URL' => 'http://example.com',
    'Seconds' => 234235
  )
  step "I go to the page where I can add a URL"
  ['Title', 'URL', 'Seconds'].each do |n|
    fill_in n, with: fields[n]
  end
  if fields['HTTP method']
    select fields['HTTP method'], from: 'HTTP method'
  end
  click_button 'Add URL'
end

##################################################

When /^I add a URL$/ do
  add_url
end

When /^I add the URL:$/ do |table|
  add_url table.rows_hash
end

When /^I add the URLs:$/ do |table|
  table.hashes.each { |fields| add_url fields }
end

When /^I change the seconds for that URL to (\d+)$/ do |seconds|
  go_to_edit_url_page
  fill_in 'Seconds', with: seconds
  click_button 'Save URL'
end

When /^I add (\d+) URLs$/ do |num|
  num.to_i.times { add_url }
end

##################################################

Then /^I should see the URLs table:$/ do |expected_table|
  actual_table = table_array '#locations table tr', 'td,th'
  diff_tables! actual_table, expected_table
end

Then /^I should see (\d+) URLs$/ do |num|
  all("#locations table tbody tr").size.should == num.to_i
end

Then /^I should see the URL info:$/ do |expected_table|
  actual_table = table_array '#location #info table tr', 'td,th'
  diff_tables! actual_table, expected_table
end