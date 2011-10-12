Feature: Pinging

  Background:
    Given I am on the home page
    And the date/time is "2011-01-01 00:00:00 UTC"

  Scenario: Creating
    Given requests to "http://example.com" are returning the status code "200"

    When I follow "Add URL"
    And I fill in the following:
      | URL     | http://example.com |
      | Seconds | 600                |
    And I press "Add"
    Then I should see "GET http://example.com"
    And I should see "Next ping in 10 minutes."
    And I should see "No pings yet"

    When 7 minutes pass
    And I refresh the page
    Then I should see "Next ping in 3 minutes."
    And I should see "No pings yet"

    When 5 minutes pass
    And I refresh the page
    Then I should see "Next ping in 8 minutes."
    And I should not see "No pings yet"
    And I should see the pings table:
      | Status |               |
      | 200    | 2 minutes ago |

    When 6 minutes pass
    And I refresh the page
    Then I should see "Next ping in 2 minutes."
    And I should see the pings table:
      | Status |               |
      | 200    | 8 minutes ago |