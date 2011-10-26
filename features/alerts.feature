Feature: Alerts

  Background:
    Given my email is "austin@example.com"

  Scenario: Email alert when site goes down
    Given requests to "http://example.com" are returning the status code "500"

    When I add the "Work Email" email callback that goes to me
    And I add the URL:
      | Title       | Example            |
      | URL         | http://example.com |
      | Seconds     | 60                 |
    And I add the alert:
      | For                         | Example    |
      | Response status code is not | 200        |
      | Times in a row              | 5          |
      | Alert via                   | Work Email |
    And 4 minutes pass
    Then I should not get an email

    When 1 minute passes
    Then I should get an '"Example" alert' email saying:
      """
      "Example" is not returning status codes of "200".
      """



  Scenario Outline: Can't add alerts without URLs or email callbacks
    When I add <thing to add>
    And I go to the alerts page
    Then I should not see "Add alert"

    Examples:
      | thing to add      |
      | an email callback |
      | a URL             |



  Scenario: Viewing alerts
    When I add the URLs:
      | Title   |
      | Google  |
      | Example |
    And I add the "Work Email" email callback that goes to me
    And I add the alert:
      | For                         | Example    |
      | Response status code is not | 200        |
      | Times in a row              | 5          |
      | Alert via                   | Work Email |
    And I add the alert:
      | For                         | Google     |
      | Response status code is not | 300        |
      | Times in a row              | 10         |
      | Alert via                   | Work Email |
    And I go to the alerts page
    Then I should see the alerts:
      | For     | Response status code is not | Times in a row | Alert via  |
      | Example | 200                         | 5              | Work Email |
      | Google  | 300                         | 10             | Work Email |