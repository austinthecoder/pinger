def add_email_callback(fields = {})
  fields.reverse_merge!('Label' => 'Work Email', 'Email' => 'me@company.com')
  steps %{
    When I go to the home page
    And I follow "Add email callback"
    And I fill in the following:
      | Label | #{fields['Label']} |
      | Email | #{fields['Email']} |
    And I press "Add email callback"
  }
end

##################################################

Given /^my email is "([^"]*)"$/ do |email|
  @my_email = email
end

##################################################

When /^I add the email callback:$/ do |table|
  add_email_callback table.rows_hash
end

When /^I add an email callback$/ do
  add_email_callback
end

When /^I add the "([^"]*)" email callback that goes to me$/ do |label|
  add_email_callback 'Label' => label, 'Email' => @my_email
end

When /^I try to add an email callback without filling out the form$/ do
  add_email_callback 'Label' => '', 'Email' => ''
end