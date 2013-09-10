def resource_infos
  @resource_infos ||= []
end

def removed_urls
  @removed_urls ||= []
end

def fill_out_resource_form(attrs = {})
  ['Title', 'URL', 'Seconds'].each do |n|
    fill_in n, :with => attrs[n]
  end
  if attrs['HTTP method']
    select attrs['HTTP method'], :from => 'HTTP method'
  end
end

def add_resource(attrs = {})
  attrs.reverse_merge!(
    'Title' => 'Page',
    'URL' => 'http://example.com',
    'Seconds' => 234235
  )
  resource_infos << attrs

  click_link 'Add resource'
  fill_out_resource_form attrs
  click_button 'Add resource'
end

def modify_url(url, attrs = {})
  urls << attrs
  visit '/'
  within "#url_#{url.id}" do
    click_on "edit"
  end
  provide_url_info attrs
  click_on 'Save URL'
end

##################################################

When /^I modify that resource$/ do
  attrs = {
    'Title' => 'New Title',
    'URL' => 'http://newurl.com',
    'HTTP method' => 'GET',
    'Seconds' => 34957
  }
  resource_infos << attrs

  visit '/'
  within "#resources" do
    click_on "edit"
  end
  fill_out_resource_form attrs
  click_on 'Save resource'
end

When /^I view that resource$/ do
  visit '/'
  within "#resources" do
    click_on resource_infos[-1]['Title']
  end
end

When /^I add a resource$/ do
  add_resource
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

When(/^I add a resource without providing the "([^"]*)"$/) do |field|
  add_resource field => nil
end

When(/^I add a resource with the URL "([^"]*)"$/) do |url|
  add_resource 'URL' => url
end

When /^I remove that resource$/ do
  visit '/'
  within "#resources" do
    click_on 'remove'
  end
  click_on "Yes, remove it"
  # removed_resources << location
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

Then /^I should see the (?:new )?info for that resource$/ do
  info = resource_infos[-1]

  within "#location" do
    ['Title', 'URL', 'HTTP method', 'Seconds'].each do |field|
      within ".#{field.downcase.gsub /\s/, '_'}" do
        page.should have_content(info[field])
      end
    end
  end
end

Then /^I should see the "([^"]*)" is required$/ do |field|
  page.should have_content("#{field} can't be blank")
end

Then /^I should see the URL is invalid$/ do
  page.should have_content("URL is invalid")
end

Then /^I should not see that URL in the list$/ do
  visit '/'
  expect do
    find("#url_#{removed_urls[-1].id}").should be_nil
  end.to raise_error(Capybara::ElementNotFound)
end

Then /^I should see that resource in the list$/ do
  visit '/'
  all("#resources .title").map(&:text).should == [resource_infos[-1]['Title']]
end

Then /^I should not see that resource in the list$/ do
  visit '/'
  all("#resources .title").map(&:text).should_not include(resource_infos[-1]['Title'])
end