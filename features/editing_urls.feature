Feature: Editing URLs

  Scenario: Editing a URL
    When I add the URL:
      | Title       | Example            |
      | URL         | http://example.com |
      | Seconds     | 100                |
      | HTTP method | GET                |
    And I go to the home page
    And I follow "edit" within the row for that URL
    And I fill in the following:
      | Title       | Changed            |
      | URL         | http://changed.com |
      | Seconds     | 2384765                |
    And I select "POST" from "HTTP method"
    And I press "Save URL"
    And I go to the home page
    Then I should see the URLs table:
      | Title   | URL                | HTTP method | Seconds |
      | Changed | http://changed.com | POST        | 2384765 |



  Scenario: Removing a URL
    When I add a URL
    And I go to the home page
    And I follow "remove" within the row for that URL
    And I confirm the removal
    And I go to the home page
    Then I should see "No URLs found"