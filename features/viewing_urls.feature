Feature: Viewing URLs

  Scenario: URLs are ordered by title
    When I add the URLs:
      | Title   | URL                | HTTP method | Seconds |
      | Google  | http://google.com  | GET         | 400     |
      | Yahoo!  | http://yahoo.com   | POST        | 600     |
      | Example | http://example.com | GET         | 100     |
    And I go to the home page
    Then I should see the URLs table:
      | Title   | URL                | HTTP method | Seconds |
      | Example | http://example.com | GET         | 100     |
      | Google  | http://google.com  | GET         | 400     |
      | Yahoo!  | http://yahoo.com   | POST        | 600     |



  Scenario: Viewing previously added URLs
    When I add the URLs:
      | Title  | URL               | HTTP method | Seconds |
      | Google | http://google.com | GET         | 400     |
      | Yahoo! | http://yahoo.com  | POST        | 600     |
    And I go to the home page
    And I follow "Google"
    Then I should see the URL info:
      | Title       | Google            |
      | URL         | http://google.com |
      | HTTP method | GET               |
      | Seconds     | 400               |



  Scenario: URLs are paginated
    Given 3 URLs are shown per page

    When I add 5 URLs
    And I go to the home page
    Then I should see 3 URLs

    When I follow "Next"
    Then I should see 2 URLs