Feature: Pinging

  Background:
    Given the date/time is "2011-01-01 00:00:00 UTC"
    And requests to "http://example.com" are returning the status code "200"

  Scenario: Viewing the pings
    When I add the URL:
      | URL     | http://example.com |
      | Seconds | 600                |
    Then I should see a ping is scheduled for 10 minutes from now
    And I should that no pings have been performed

    When I refresh the page after 7 minutes
    Then I should see a ping is scheduled for 3 minutes from now
    And I should that no pings have been performed

    When I refresh the page after 5 minutes
    Then I should see a ping is scheduled for 8 minutes from now
    And I should see 1 ping was performed 2 minutes ago

    When I refresh the page after 6 minutes
    Then I should see a ping is scheduled for 2 minutes from now
    And I should see 1 ping was performed 8 minutes ago


  Scenario: Pings are ordered newest first
    When I add the URL:
      | URL     | http://example.com |
      | Seconds | 600                |
    And I refresh the page after 30 minutes
    Then I should 3 pings were performed
    And I should see the newest ping was just performed
    And I should see the oldest ping was performed 20 minutes ago


  Scenario: Pings are paginated
    When I add the URL:
      | URL     | http://example.com |
      | Seconds | 60                 |
    And I refresh the page after 3 minutes
    Then I should see 3 pings

    When I refresh the page after 2 minutes
    Then I should see 3 pings

    When I follow "Next"
    Then I should see 2 pings