Feature: Alerts

  Scenario: Email alert when site goes down
    Given requests to "http://example.com" are returning the status code "500"
    And my email is "austin@example.com"

    When I add an email callback that goes to me
    And I add the URL:
      | Title       | Example            |
      | URL         | http://example.com |
      | Seconds     | 60                 |
    And I add an alert to perform that callback when that URL does't return a response status code of "200" 5 times in a row
    And 4 minutes pass
    Then I should not get an email

    When 1 minute passes
    Then I should get an '"Example" alert' email saying:
      """
      "Example" is not returning status codes of "200".
      """