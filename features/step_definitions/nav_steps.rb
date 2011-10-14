Given /^I am on the home page$/ do
  visit root_path
end

##################################################

When /^I go to the home page$/ do
  visit root_path
end

When /^I go to the page where I can add a URL$/ do
  steps %{
    When I go to the home page
    And I follow "Add URL"
  }
end