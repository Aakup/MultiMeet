Feature: participants can enter preferences

As a participant,
So that I can select which times I like and get the times I want,
I want to be able to rank the times.

Background: A project is set up and participants are invited to rank times
#    Given a registered user with the email "raichu@berkeley.edu" with username "raichu" exists
    Given a user with the email "raichu@berkeley.edu" with password "password" and with username "raichu" exists
    And a registered user with the username "raichu" has a project named "CS169 Sections"
    And I am on the login page
    When I fill in "Email" with "raichu@berkeley.edu"
    And I fill in "Password" with "password"
    And I press "Log In"
    And the project named "CS169 Sections" has the following participants:
    | email                  |
    | empoleon@berkeley.edu  |
    | charizard@berkeley.edu |

    And the project named "CS169 Sections" has the following times:
    | datetime               |
    | Dec 1 2019 10:00 AM    |
    | Dec 1 2019 1:00 PM     |

    And a participant to project "CS169 Sections" with email "empoleon@berkeley.edu" has a secret_id "empoleonsecretid"
    And a participant to project "CS169 Sections" with email "charizard@berkeley.edu" has a secret_id "charizardsecretid"

  Scenario: User enters their preferences for times
    When I access the time ranking page for project "CS169 Sections" from email "empoleon@berkeley.edu" and secret_id "empoleonsecretid"
    Then I should see "Enter your preferences for these times."
    And I should not see "Access denied"
    When I choose "Can't go" for time "Dec 1 2019 10:00 AM"
    And I choose "1" for time "Dec 1 2019 1:00 PM"
    And I press "Submit"
    Then I should see "Thanks for submitting your preferences!"

  Scenario: User attempts to enter preferences with the wrong secret id
    When I access the time ranking page for project "CS169 Sections" from email "empoleon@berkeley.edu" and secret_id "empoleonfakesecretid"
    Then I should see "Access denied."

#  Scenario: User attempts to enter preferences for times for a project that they are not a part of
#    When I access the time ranking page for project of id "1" from user id "6" and secret_id "none"
#    Then I should see "Access denied."

#  Scenario: User attempts to enter preferences for times for a project that does not exist
#    I access the time ranking page for project of id "99" from user id "6" and secretid "none"
#    Then I should see "Project does not exist."

#  Scenario: User submits without filling out all of the preferences
#    When I access the time ranking page for project "CS169 Sections" from email "empoleon@berkeley.edu" and secret_id "empoleonsecretid"
#    Then I should see "Please enter your preferences for these times."
#    When I choose "Cannot go" for time "Dec 1 2019 10:00 AM"
#    And I press "Submit"
#    Then I should see "Error: please fill in an option for each time."

  Scenario: User has a match degree of greater than one, but only selects one time they can go to and runs into an error
    When I am on the participants page for "CS169 Sections"
    Then I am on the project participants page for "empoleon@berkeley.edu" for project "CS169 Sections"
    And I fill in "Match Degree" with "2"
    And I press "Update Participant"
    Then I should see "Successfully updated participant"
    Then I am on the participants page for "CS169 Sections"
    And the match degree of "empoleon@berkeley.edu" should be 2

    When I access the time ranking page for project "CS169 Sections" from email "empoleon@berkeley.edu" and secret_id "empoleonsecretid"
    Then I should see "Enter your preferences for these times."
    When I choose "1" for time "Dec 1 2019 1:00 PM"
    When I choose "Can't go" for time "Dec 1 2019 10:00 AM"
    And I press "Submit"
    Then I should see "Error: you must be available for at least 2 times."
