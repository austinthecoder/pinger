Feature: Pinging

  Background:
    Given the date/time is "2011-01-01 00:00:00 UTC"
    And requests to "http://example.com" are returning the status code "200"

  Scenario: Viewing the pings
    When I create the URL:
      | URL     | http://example.com |
      | Seconds | 600                |
    And I should see "Next ping in 10 minutes."
    And I should see "No pings yet"

    And I refresh the page after 7 minutes
    Then I should see "Next ping in 3 minutes."
    And I should see "No pings yet"

    And I refresh the page after 5 minutes
    Then I should see "Next ping in 8 minutes."
    And I should see the pings table:
      | Status |                              |
      | 200    | Jan  1, 2011 at 12:10:00 AM UTC |

    And I refresh the page after 6 minutes
    Then I should see "Next ping in 2 minutes."
    And I should see the pings table:
      | Status |                              |
      | 200    | Jan  1, 2011 at 12:10:00 AM UTC |



  Scenario: Pings are ordered newest first
    When I create the URL:
      | URL     | http://example.com |
      | Seconds | 600                |
    And I refresh the page after 30 minutes
    Then I should see the pings table:
      | Status |                              |
      | 200    | Jan  1, 2011 at 12:30:00 AM UTC |
      | 200    | Jan  1, 2011 at 12:20:00 AM UTC |
      | 200    | Jan  1, 2011 at 12:10:00 AM UTC |



  Scenario: Changing the seconds
    When I create the URL:
      | URL     | http://example.com |
      | Seconds | 600                |
    And I change the seconds for that URL to 60
    And I go to the page for that URL
    Then I should see "Next ping in 1 minute"

    And I refresh the page after 1 minute
    Then I should see the pings table:
      | Status |                                 |
      | 200    | Jan  1, 2011 at 12:01:00 AM UTC |