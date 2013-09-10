Feature: Email callbacks

Background:
  Given I am on this site

Scenario: Adding one shows it in the list
  When I add an email callback
  Then I should see that email callback in the list


Scenario: Email callbacks can't have the same label
  When I add an email callback
  And I add an email callback with the same label
  Then I should see that label was already taken


Scenario: Can't add a callback without an email address or label
  When I try to add an email callback without providing any info
  Then I should see the label can't be blank
  And I should see the email can't be blank


Scenario: Modifying an email callback
  When I add an email callback
  And I modify that email callback
  And I view the list of email callbacks
  Then I should see the new info for that email callback


Scenario: Removing email callbacks
  When I add an email callback
  And I remove that email callback
  And I go to the email callbacks page
  Then I should not see that email callback