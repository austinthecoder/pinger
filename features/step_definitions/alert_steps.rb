def add_alert(fields = {})
  visit root_path
  click_link fields['For'] || Location.last.title
  click_link 'Add alert'
  ['Response status code is not', 'Times in a row'].each do |n|
    fill_in n, with: fields[n]
  end
  select(fields['Alert via'], from: 'Alert via') if fields['Alert via']
  click_button 'Add alert'
end

##################################################

When /^I add the alert:$/ do |table|
  add_alert table.rows_hash
end

When /^I try to add an alert without filling out the form$/ do
  add_alert 'Response status code is not' => '', 'Times in a row' => ''
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
  actual_table = table_array '#alerts table tr', 'td,th'
  diff_tables! actual_table, expected_table
end