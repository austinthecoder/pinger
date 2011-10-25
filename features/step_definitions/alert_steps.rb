def add_alert(fields = {})
  steps %{
    When I go to the home page
    And I follow "Alerts"
    And I follow "Add alert"
    And I fill in the following:
      | Response status code is not | #{fields['Response status code is not']} |
      | Times in a row              | #{fields['Times in a row']}              |
  }
  And %{I select "#{fields['For']}" from "For"} if fields['For']
  And %{I select "#{fields['Alert via']}" from "Alert via"} if fields['Alert via']
  And %{I press "Add alert"}
end

##################################################

When /^I add the alert:$/ do |table|
  add_alert table.rows_hash
end

##################################################

Then /^I should not get an email$/ do
  ActionMailer::Base.deliveries.last.should be_nil
end

Then /^I should get an? '([^']*)' email saying:$/ do |subject, message|
  email = ActionMailer::Base.deliveries.last
  email.should_not be_nil
  email.to.should == [@my_email]
  email.subject.should == subject
  email.body.encoded.should == message
end

Then /^I should see the alerts:$/ do |expected_table|
  actual_table = table_array('#alerts table tr', 'td,th')
  diff_tables!(actual_table, expected_table)
end