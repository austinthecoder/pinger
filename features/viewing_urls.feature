Feature: Viewing URLs

  Scenario: URLs are ordered by title
    When I create the URLs:
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



  Scenario: Viewing previously created URLs
    When I create the URLs:
      | Title  | URL               | HTTP method | Seconds |
      | Google | http://google.com | GET         | 400     |
      | Yahoo! | http://yahoo.com  | POST        | 600     |
    And I go to the home page
    And I follow "Google"
    Then I should see "GET request to http://google.com"