Feature: Match

  As an admin,
  I want to run the matching algorithm
  So users can be assigned a time

  Background: A project is set up and matchings exist
    Given a registered user with the email "kevinchien@berkeley.edu" with username "kev-chien" exists
    And I am on the login page
    When I fill in "Email" with "kevinchien@berkeley.edu"
    And I fill in "Password" with "password"
    And I press "Log In"
    And a registered user with the username "kev-chien" has a project named "CS61A Sections"
    And the project named "CS61A Sections" has the following participants:
    | email |
    | nobodyhere@berkeley.edu |
    | plsdontemailme@berkeley.edu |

    And the project named "CS61A Sections" has the following times:
      | datetime            |
      | Dec 1 2019 10:00 AM |
      | Dec 1 2019 1:00 PM  |

    When I am on the participants page for "CS61A Sections"
    When I autofill rankings for "nobodyhere@berkeley.edu"
    When I autofill rankings for "plsdontemailme@berkeley.edu"
    And the project named "CS61A Sections" has a two-person matching
    Then I am on the matchings page for "CS61A Sections"

  Scenario: successfully email matchings
    And I fill in "email_body" with "Hello, your final matching has been assigned!"
    And I press "Send Email"
    Then the user "nobodyhere@berkeley.edu" should receive a matching email with the correct timestamp "Sunday, December 01 2019 10:00 AM"
    Then I should see "Emails have been sent."
