When /^I go to the home page$/ do
  visit root_path
end

When /^I go to the page where I can add a URL$/ do
  visit root_path
  click_link 'Add URL'
end

When /^I go to the edit page for that URL$/ do
  visit root_path
  And %{I follow "edit" within the row for that URL} # refactor
end

When /^I go to the page for that URL$/ do
  visit root_path
  click_link Location.last.title
end

When /^I go to the alerts page$/ do
  visit root_path
  click_link 'Alerts'
end