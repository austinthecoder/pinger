When /^I add the email callback:$/ do |table|
  steps %{
    When I go to the home page
    And I follow "Add email callback"
  }
  And "I fill in the following:", table
  And %{I press "Add email callback"}
end