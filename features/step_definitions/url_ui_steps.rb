def add_url(args = {})
  args.reverse_merge!(
    'Title' => 'Page',
    'URL' => 'http://example.com',
    'Seconds' => 234235
  )
  steps %{
    When I go to the page where I can add a URL
    And I fill in the following:
      | Title   | #{args['Title']}   |
      | URL     | #{args['URL']}     |
      | Seconds | #{args['Seconds']} |
  }
  if args['HTTP method']
    And %{I select "#{args['HTTP method']}" from "HTTP method"}
  end
  And %{I press "Add URL"}
end

##################################################

Given /^(\d+) URLs are shown per page$/ do |num|
  UserPresenter.locations_per_page = num.to_i
end

##################################################

When /^I add a URL$/ do
  add_url
end

When /^I add the URL:$/ do |table|
  add_url(table.rows_hash)
end

When /^I add the URLs:$/ do |table|
  table.hashes.each do |args|
    add_url(args)
  end
end

When /^I change the seconds for that URL to (\d+)$/ do |seconds|
  steps %{
    When I go to the edit page for that URL
    And I fill in the following:
      | Seconds | #{seconds} |
    And I press "Save URL"
  }
end

When /^I add (\d+) URLs$/ do |num|
  num.to_i.times { add_url }
end

##################################################

Then /^I should see the URLs table:$/ do |expected_table|
  actual_table = tableish('#locations table tr', 'td,th')
  diff_tables!(actual_table, expected_table)
end

Then /^I should see (\d+) URLs$/ do |num|
  all("#locations table tbody tr").size.should == num.to_i
end