Feature: Email callbacks

  Scenario: Viewing the list of email callbacks
    When I add the email callbacks:
      | Label          | Email               |
      | Work Email     | austin@company.com  |
      | Another One    | someguy@example.com |
      | Personal Email | me@austin.com       |
    And I go to the email callbacks page
    Then I should see the email callbacks:
      | Label          | Email               |
      | Another One    | someguy@example.com |
      | Personal Email | me@austin.com       |
      | Work Email     | austin@company.com  |



  Scenario: Email callbacks can't have the same label
    When I add the "Me" email callback
    And I add the "Me" email callback
    Then I should see "Has already been taken" within the "Label" field



  Scenario: Can't add a callback without an email address or label
    When I try to add an email callback without filling out the form
    Then I should see "Can't be blank" within the "Label" field
    And I should see "Can't be blank" within the "Email" field



  Scenario: Changing email callback
    When I add an email callback
    And I edit that email callback to:
      | Label | Changed Label       |
      | Email | changed@example.com |
    And I go to the email callbacks page
    Then I should see the email callbacks:
      | Label         | Email               |
      | Changed Label | changed@example.com |

