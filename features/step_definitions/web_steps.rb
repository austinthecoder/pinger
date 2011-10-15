When /^I follow "([^"]*)"$/ do |link|
  click_link(link)
end

When /^I fill in the following:$/ do |fields|
  fields.rows_hash.each do |field, value|
    fill_in(field, :with => value)
  end
end

When /^I press "([^"]*)"$/ do |button|
  click_button(button)
end

When /^I refresh the page$/ do
  visit current_url
end

When /^I refresh the page after (\d+) minutes$/ do |mins|
  steps %{
    When #{mins} minutes pass
    And I refresh the page
  }
end

When /^I select "([^"]*)" from "([^"]*)"$/ do |value, field|
  select(value, :from => field)
end

# Single-line step scoper
When /^(.*) within (.*[^:])$/ do |step, parent|
  with_scope(parent) { When step }
end

##################################################

Then /^I should see "([^"]*)"$/ do |text|
  page.should have_content(text)
end

Then /^I should not see "([^"]*)"$/ do |text|
  page.should_not have_content(text)
end