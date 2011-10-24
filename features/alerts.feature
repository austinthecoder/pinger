Feature: Alerts

  Background:
    Given my email is "austin@example.com"

  Scenario: Email alert when site goes down
    Given requests to "http://example.com" are returning the status code "500"

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



  Scenario: Can't add a callback without an email address or label
    When I go to the home page
    And I follow "Add email callback"
    And I press "Add email callback"

    Then I should see "Can't be blank" within the "Label" field
    And I should see "Can't be blank" within the "Email" field



  Scenario: Can't add an alert when there's no URLs
    When I go to the home page
    Then I should not see "Add alert"



  Scenario: Viewing alerts
    When I add the URLs:
      | Title   |
      | Google  |
      | Example |
    And I add the email callback:
      | Label | My Email           |
      | Email | austin@example.com |
    And I add the alert:
      | For                         | Example  |
      | Response status code is not | 200      |
      | Times in a row              | 5        |
      | Alert via                   | My Email |
    And I add the alert:
      | For                         | Google   |
      | Response status code is not | 300      |
      | Times in a row              | 10       |
      | Alert via                   | My Email |
    And I go to the alerts page
    Then I should see the alerts:
      | For     | Response status code is not | Times in a row | Alert via |
      | Example | 200                         | 5              | My Email  |
      | Google  | 300                         | 10             | My Email  |