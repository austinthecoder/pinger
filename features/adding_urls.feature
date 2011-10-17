Feature: Adding URLs

  Scenario: Adding a URL
    When I go to the page where I can add a URL
    And I fill in the following:
      | Title   | Example Home       |
      | URL     | http://example.com |
      | Seconds | 600                |
    And I select "POST" from "HTTP method"
    And I press "Add URL"
    Then I should see "Sending a POST request to http://example.com every 600 seconds."



  Scenario: Adding an invalid URL
    When I go to the page where I can add a URL
    And I press "Add URL"
    Then I should see "Can't be blank" within the "Title" field
    And I should see "Can't be blank" within the "URL" field
    And I should see "Can't be blank" within the "Seconds" field

    When I fill in the following:
      | Title   | Example Home |
      | URL     | 384756       |
      | Seconds | foo          |
    And I press "Add URL"
    Then I should see "Is invalid" within the "URL" field
    And I should see "Is not a number" within the "Seconds" field