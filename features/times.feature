Feature: Choose times

  As a logged in user
  So that I know when to meet
  I can input my desired times

  Background: user is logged in
    Given a user with the email "daniellee0228@berkeley.edu" with password "password" and with username "daniel908908" exists
    And a registered user with the username "daniel908908" has a project named "Party 1"
    And I am on the login page
    When I fill in "Email" with "daniellee0228@berkeley.edu"
    And I fill in "Password" with "password"
    And I press "Log In"
    Then I should be on the projects page

  Scenario: Choose times from project creation page
    When I follow "New Project"
    Then I should see "Enter the name of your new project here"
    When I fill in "Project Name" with "Party 2"
    And I press "Create Project and Choose Times"
    Then I should see "Successfully created project Party 2. Choose dates and times now!"
    Then I should see "Step 1: Choose Duration"
    And I select "2" from "timeslot_hour"
    And I select "30" from "timeslot_minute"
    Then I should see "Step 2: Choose Dates"

  Scenario: Choose times from projects page
    Given I am on the projects page
    When I follow "Show"
    Then I should see "Name: Party 1"
    And I should see "Times"
    When I follow "Times"
    Then I should see "Project Times"
    When I follow "Add new time"
    Then I should see "Step 1: Choose Duration"

  Scenario: No date chosen
    Given I access the times page for project of id "1"
    And I follow "Add new time"
    Then I should see "Step 1: Choose Duration"
    And I press "Submit"
    Then I should see "Error: No date chosen."

  Scenario: Show dates and times after choosing
    Given a project of id "1" with date "Dec 1 2019" and time "Dec 1 2019 10:00 AM" and duration "60"
    When I am on the projects page
    And I follow "Show"
    Then I should see "Duration (minutes): 60"
    And I follow "Times"
    Then I should see "Sunday, December 01 2019"

  Scenario: Duration already set
    Given a project of id "1" with date "Dec 1 2019" and time "Dec 1 2019 10:00 AM" and duration "60"
    And I access the times page for project of id "1"
    And I follow "Add new time"
    Then I should see "Current Timeslot Length: 60 minutes"
    And I should see "Change Duration"

  Scenario: Reselect Times
    Given a project of id "1" with date "Dec 1 2019" and time "Dec 1 2019 10:00 AM" and duration "60"
    And I access the times page for project of id "1"
    And I follow "Reselect Times"
    Then I should see "Current Timeslot Duration: Not set yet"
