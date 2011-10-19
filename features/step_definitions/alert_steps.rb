Given /^my email is "([^"]*)"$/ do |email|
  @my_email = email
end

##################################################

When /^I add an email callback that goes to me$/ do
  steps %{
    When I go to the home page
    And I follow "Add email callback"
    And I fill in the following:
      | Label   | Personal           |
      | Address | austin@example.com |
    And I press "Add email callback"
  }
end

When /^I add an alert to perform that callback when that URL does't return a response status code of "([^"]*)" (\d+) times in a row$/ do |code, times_in_a_row|
  callback = EmailCallback.last
  location = Location.last

  steps %{
    When I go to the home page
    And I follow "Add alert"
    And I select "#{location.title}" from "For"
    And I fill in the following:
      | Response status code is not | #{code}           |
      | Times in a row              | #{times_in_a_row} |
    And I select "#{callback.label}" from "Alert via"
    And I press "Add alert"
  }
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