def go_to_edit_url_page
  visit root_path
  with_scope "the row for that URL" do
    click_link "edit"
  end
end

def go_to_email_callbacks_page
  visit root_path
  click_link 'Email callbacks'
end

When /^I go to the home page$/ do
  visit root_path
end

When /^I go to the page where I can add a URL$/ do
  visit root_path
  click_link 'Add URL'
end

When /^I go to the edit page for that URL$/ do
  go_to_edit_url_page
end

When /^I go to the page for that URL$/ do
  visit root_path
  click_link Location.last.title
end

When /^I go to the alerts page$/ do
  visit root_path
  click_link 'Alerts'
end

When /^I go to the email callbacks page$/ do
  go_to_email_callbacks_page
end