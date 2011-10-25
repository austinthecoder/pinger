def add_email_callback(fields = {})
  fields.reverse_merge! 'Label' => 'Work Email', 'Email' => 'me@company.com'
  visit root_path
  click_link 'Add email callback'
  ['Label', 'Email'].each { |n| fill_in n, :with => fields[n] }
  click_button 'Add email callback'
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