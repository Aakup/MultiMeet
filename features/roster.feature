Feature: Roster

  As a logged in user,
  So that I can display my roster,
  I can add a new participant to my roster.

  Background: user is logged in
    Given a user with the email "aaronli98@berkeley.edu" with password "password" and with username "aaronli98" exists
    And a registered user with the username "aaronli98" has a project named "Test Meeting 1" with id "1"
    And a registered user with the username "aaronli98" has a project named "Test Meeting 2" with id "2"
    And I am on the login page
    When I fill in "Email" with "aaronli98@berkeley.edu"
    And I fill in "Password" with "password"
    And I press "Log In"
    Then I should be on the projects page
    And I should see "aaronli98"

  Scenario: successfully create a new project
    When I follow "New Project"
    Then I should see "Enter the name of your new project here"
    When I fill in "Project Name" with "Test Meeting 3"
    And I press "Create Project"
    Then I should be on the projects page
    And I should see "Successfully created project Test Meeting 3"

  Scenario: successfully to display rosters
    When I press the roster bottom for project of id "1"
    Then I follow "Enter Manually"
    Then I should see "Listing Participants"
    When I fill in "Email" with "testing1@berkeley.edu"
    And I press "Add New Participant"
    And I fill in "Email" with "testing2@berkeley.edu"
    And I press "Add New Participant"
    And I fill in "Email" with "testing3@berkeley.edu"
    And I press "Add New Participant"
    Then I should see "Successfully created participant testing3@berkeley.edu"
    When I fill in "Email" with "testing3@berkeley.edu"
    And I press "Add New Participant"
    Then I should see "Participant's email already exists"
    When I follow "Back to All Projects"
    Then I should be on the projects page
    When I press the roster bottom for project of id "1"
    And I follow "Enter Manually"
    Then I should see "testing1@berkeley.edu"
    Then I should see "testing2@berkeley.edu"
    Then I should see "testing3@berkeley.edu"
    When I follow "Back to All Projects"
    Then I should be on the projects page

  Scenario: successfully to edit project name
    When I press the edit bottom for project of id "1"
    Then I should see "Editing Project"
    When I fill in "New Project Name" with "Testing Meeting 1_1"
    And I press "Confirm Editing"
    Then I should be on the projects page
    And I should see "Testing Meeting 1_1"

  Scenario: successfully to destroy participant
    When I press the roster bottom for project of id "2"
    Then I follow "Enter Manually"
    Then I should see "Listing Participants"
    When I fill in "Email" with "testing4@berkeley.edu"
    And I press "Add New Participant"
    When I follow "DELETE"
    Then I should not see "testing4@berkeley.edu"
    When I follow "Back to All Projects"
    Then I should be on the projects page
