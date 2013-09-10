Feature: Resource management

Background:
  Given I am on this site

Scenario: Adding a resource
  When I add a resource
  Then I should see that resource in the list


Scenario: Viewing a resource
  When I add a resource
  And I view that resource
  Then I should see the info for that resource


Scenario Outline: Some fields are required when adding resources
  When I add a resource without providing the "<attribute>"
  Then I should see the "<attribute>" is required

  Examples:
    | attribute |
    | Title     |
    | Seconds   |


Scenario: resource URL must be formatted correctly
  When I add a resource with the URL "foo"
  Then I should see the URL is invalid


Scenario: Modifying a resource
  When I add a resource
  And I modify that resource
  And I view that resource
  Then I should see the new info for that resource


Scenario: Removing a resource
  When I add a resource
  And I remove that resource
  Then I should not see that resource in the list