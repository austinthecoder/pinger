def email_callback_info
  @email_callback_info ||= []
end

def fill_in_email_callback_form(attrs = {})
  ['Label', 'Email'].each do |field|
    fill_in field, with: attrs[field]
  end
end

def add_email_callback(attrs = {})
  unless attrs[:no_info]
    attrs.reverse_merge! 'Label' => 'Work Email', 'Email' => 'me@company.com'
  end
  email_callback_info << attrs

  go_to_email_callbacks_page
  click_link 'Add email callback'
  fill_in_email_callback_form attrs
  click_button 'Add email callback'
end

def remove_email_callback(email_callback)
  go_to_email_callbacks_page
  within "#email_callback_#{email_callback.id}" do
    click_link 'remove'
  end
  click_button 'Yes, remove it'
end

##################################################

Given(/^my email is "([^"]*)"$/) do |email|
  @my_email = email
end

##################################################

When /^I try to add an email callback without providing any info$/ do
  add_email_callback :no_info => true
end

When /^I add an email callback with the same label$/ do
  add_email_callback 'Label' => email_callback_info[-1]['Label']
end

When /^I modify that email callback$/ do
  go_to_email_callbacks_page
  click_link 'edit'
  attrs = {'Label' => 'Changed Label', 'Email' => 'Changed Email'}
  email_callback_info << attrs

  fill_in_email_callback_form attrs
  click_button 'Save email callback'
end

When /^I view the list of email callbacks$/ do
  go_to_email_callbacks_page
end

When /^I add an email callback$/ do
  add_email_callback
end

When(/^I add the "([^"]*)" email callback that goes to me$/) do |label|
  add_email_callback 'Label' => label, 'Email' => @my_email
end

When /^I try to add an email callback without filling out the form$/ do
  add_email_callback 'Label' => '', 'Email' => ''
end

When(/^I add the "([^"]*)" email callback$/) do |label|
  add_email_callback 'Label' => label
end

When /^I add the email callbacks:$/ do |table|
  table.hashes.each { |fields| add_email_callback fields }
end

When /^I remove that email callback$/ do
  @email_callback = EmailCallback.last
  remove_email_callback @email_callback
end

##################################################

Then /^I should see that email callback$/ do
  attrs = email_callback_info[-1]
  context = all("#email_callbacks .email_callback")[0]
  context.should have_content(attrs['Label'])
  context.should have_content(attrs['Email'])
end

Then /^I should not see that email callback$/ do
  within "#email_callbacks" do
    page.should_not have_content(@email_callback.label)
    page.should_not have_content(@email_callback.to)
  end
end

Then /^I should see that email callback was changed$/ do
  attrs = email_callback_info[-1]
  context = all("#email_callbacks .email_callback")[0]
  context.should have_content(attrs['Label'])
  context.should have_content(attrs['Email'])
end

Then /^I should see that email callback in the list$/ do
  visit '/'
  click_on 'Email callbacks'
  all("#email_callbacks .label").map(&:text).should == [email_callback_info[-1]['Label']]
end

Then /^I should see that label was already taken$/ do
  page.should have_content("Label has already been taken")
end

Then(/^I should see the label can't be blank$/) do
  page.should have_content("Label can't be blank")
end

Then(/^I should see the email can't be blank$/) do
  page.should have_content("Email can't be blank")
end

Then /^I should see the new info for that email callback$/ do
  that_email_callback = email_callback_info[-1]
  all("#email_callbacks .label").map(&:text).should == [that_email_callback['Label']]
  all("#email_callbacks .email").map(&:text).should == [that_email_callback['Email']]
end