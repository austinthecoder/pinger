Given /^my email is "([^"]*)"$/ do |email|
  @my_email = email
end

##################################################

When /^I add an email callback that goes to me$/ do
  steps %{
    When I go to the home page
    And I follow "Add email callback"
    And I fill in the following:
      | Label | Personal           |
      | Email | austin@example.com |
    And I press "Add email callback"
  }
end

When /^I add an alert to perform that callback when that URL does't return a response status code of "([^"]*)" (\d+) times in a row$/ do |code, times_in_a_row|
  steps %{
    When I add the alert:
      | For                         | #{Location.last.title}      |
      | Response status code is not | #{code}                     |
      | Times in a row              | #{times_in_a_row}           |
      | Alert via                   | #{EmailCallback.last.label} |
  }
end

When /^I add the alert:$/ do |table|
  args = table.rows_hash
  steps %{
    When I go to the home page
    And I follow "Add alert"
    And I fill in the following:
      | Response status code is not | #{args['Response status code is not']} |
      | Times in a row              | #{args['Times in a row']}              |
  }
  And %{I select "#{args['For']}" from "For"} if args['For']
  And %{I select "#{args['Alert via']}" from "Alert via"} if args['Alert via']
  And %{I press "Add alert"}
end

##################################################

Then /^I should not get an email$/ do
  ActionMailer::Base.deliveries.last.should be_nil
end

Then /^I should get an? '([^']*)' email saying:$/ do |subject, message|
  email = ActionMailer::Base.deliveries.last
  email.to.should == [@my_email]
  email.subject.should == subject
  email.body.encoded.should == message
end

Then /^I should see the alerts:$/ do |expected_table|
  actual_table = table_array('#alerts table tr', 'td,th')
  diff_tables!(actual_table, expected_table)
end