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

When /^I go to the edit page for that URL$/ do
  steps %{
    When I go to the home page
    And I follow "edit" within the row for that URL
  }
end

When /^I go to the page for that URL$/ do
  location = Location.last
  steps %{
    When I go to the home page
    And I follow "#{location.title}"
  }
end