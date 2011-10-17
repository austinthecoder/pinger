Feature: Viewing URLs

  Scenario: Viewing the URLs
    When I create the URLs:
      | Title  | URL               | HTTP method | Seconds |
      | Google | http://google.com | GET         | 400     |
      | Yahoo! | http://yahoo.com  | POST        | 600     |
    And I go to the home page
    Then I should see the URLs table:
      | Title  | URL               | HTTP method | Seconds |
      | Yahoo! | http://yahoo.com  | POST        | 600     |
      | Google | http://google.com | GET         | 400     |

    When I create the URL:
      | Title       | Example            |
      | URL         | http://example.com |
      | Seconds     | 100                |
      | HTTP method | GET                |
    And I go to the home page
    Then I should see the URLs table:
      | Title   | URL                | HTTP method | Seconds |
      | Example | http://example.com | GET         | 100     |
      | Yahoo!  | http://yahoo.com   | POST        | 600     |
      | Google  | http://google.com  | GET         | 400     |



  Scenario: Viewing previously created URLs
    When I create the URLs:
      | Title  | URL               | HTTP method | Seconds |
      | Google | http://google.com | GET         | 400     |
      | Yahoo! | http://yahoo.com  | POST        | 600     |
    And I go to the home page
    And I follow "Google"
    Then I should see "GET request to http://google.com"