def add_email_callback(fields = {})
  fields.reverse_merge! 'Label' => 'Work Email', 'Email' => 'me@company.com'
  go_to_email_callbacks_page
  click_link 'Add email callback'
  ['Label', 'Email'].each { |n| fill_in n, :with => fields[n] }
  click_button 'Add email callback'
end

def edit_email_callback(email_callback, fields = {})
  go_to_email_callbacks_page
  click_link 'edit'
  ['Label', 'Email'].each do |n|
    fill_in(n, :with => fields[n]) if fields[n]
  end
  click_button 'Save email callback'
end

def remove_email_callback(email_callback)
  go_to_email_callbacks_page
  within "#email_callback_#{email_callback.id}" do
    click_link 'remove'
  end
  click_button 'Yes, remove it'
end

##################################################

Given /^my email is "([^"]*)"$/ do |email|
  @my_email = email
end

##################################################

When /^I add an email callback$/ do
  add_email_callback
end

When /^I add the "([^"]*)" email callback that goes to me$/ do |label|
  add_email_callback 'Label' => label, 'Email' => @my_email
end

When /^I try to add an email callback without filling out the form$/ do
  add_email_callback 'Label' => '', 'Email' => ''
end

When /^I add the "([^"]*)" email callback$/ do |label|
  add_email_callback 'Label' => label
end

When /^I add the email callbacks:$/ do |table|
  table.hashes.each { |fields| add_email_callback fields }
end

When /^I edit that email callback to:$/ do |table|
  edit_email_callback EmailCallback.last, table.rows_hash
end

When /^I remove that email callback$/ do
  @email_callback = EmailCallback.last
  remove_email_callback @email_callback
end

##################################################

Then /^I should see the email callbacks:$/ do |expected_table|
  actual_table = table_array '#email_callbacks table tr', 'td,th'
  diff_tables! actual_table, expected_table
end

Then /^I should not see that email callback$/ do
  within "#email_callbacks" do
    page.should_not have_content(@email_callback.label)
    page.should_not have_content(@email_callback.to)
  end
end