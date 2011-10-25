Given /^requests to "([^"]*)" are returning the status code "([^"]*)"$/ do |url, code|
  FakeWeb.stub_request url, :code => code
end