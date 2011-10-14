When /^I create the URL:$/ do |table|
  args = table.rows_hash
  steps %{
    When I follow "Add URL"
    And I fill in the following:
      | URL     | #{args['URL']}     |
      | Seconds | #{args['Seconds']} |
  }
  if args['HTTP method']
    And %{I select "#{args['HTTP method']}" from "HTTP method"}
  end
  And %{I press "Add"}
end