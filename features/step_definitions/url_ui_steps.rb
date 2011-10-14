def create_url(args = {})
  args.reverse_merge!('Title' => 'Page')
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

When /^I create the URL:$/ do |table|
  create_url(table.rows_hash)
end

When /^I create the URLs:$/ do |table|
  table.hashes.each do |args|
    create_url(args)
  end
end

Then /^I should see the URLs table:$/ do |expected_table|
  actual_table = tableish('#locations table tr', 'td,th')
  diff_tables!(actual_table, expected_table)
end