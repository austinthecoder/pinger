Feature: Email callbacks

  Scenario: Can't add a callback without an email address or label
    When I try to add an email callback without filling out the form
    Then I should see "Can't be blank" within the "Label" field
    And I should see "Can't be blank" within the "Email" field



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