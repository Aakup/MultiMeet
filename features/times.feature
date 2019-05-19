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

  Scenario: User submits with 0 minutes for duration
    When I follow "New Project"
    When I fill in "Project Name" with "Lan party"
    And I press "Choose Times"
    When I send a POST request to "/projects/2/times" with:
      """
      {
        "timeslot_hour":"0",
        "timeslot_minute":"0",
        "project_time":{"date_time":"2019-04-26"},
        "times":{"2019-04-26":["09:00", "9:00"]},
        "commit":"Submit",
        "project_id":"1"
      }
      """
    And I follow "Back"
    Then I should see "Current Timeslot Duration: Not set yet"

  Scenario: Choose times from project creation page
    When I follow "New Project"
    Then I should see "Enter name of new project"
    When I fill in "Project Name" with "Party 2"
    And I press "Choose Times"
    Then I should see "Successfully created project Party 2. Choose dates and times now!"
    When I send a POST request to "/projects/2/times" with:
      """
      {
        "timeslot_hour":"2",
        "timeslot_minute":"0",
        "project_time":{"date_time":"2019-04-26"},
        "times":{"2019-04-26":["08:00", "10:00"]},
        "commit":"Submit",
        "project_id":"2"
      }
      """
    And I follow "Back"
    Then I should see "Friday, April 26 2019"
    Then I should see "Start: 08:00 AM"
    Then I should see "End: 10:00 AM"
    Then I should see "Reselect Times"
    Then I should see "Duration: 120 minutes"

  Scenario: Choose times from projects page
    Given I am on the projects page
    When I follow "Party 1"
    Then I should see "Party 1"
    And I should see "Times"
    When I follow "Times"
    Then I should see "Project Times"
    When I follow "Add new time"
    Then I should see "Step 1: Choose Duration"

  Scenario: No date chosen
    Given I am on the times page for "Party 1"
    And I follow "Add new time"
    Then I should see "Step 1: Choose Duration"
    And I press "Submit"
    Then I should see "No date chosen."

  Scenario: Show dates and times after choosing
    Given a project of id "1" with date "Dec 1 2019" and time "Dec 1 2019 10:00 AM" and duration "60"
    When I am on the projects page
    And I follow "Party 1"
    Then I should see "Current Timeslot Duration: 60 minutes"
    And I follow "Times"
    Then I should see "Sunday, December 01 2019"

  Scenario: Duration already set
    Given a project of id "1" with date "Dec 1 2019" and time "Dec 1 2019 10:00 AM" and duration "60"
    Given I am on the times page for "Party 1"
    And I follow "Add new time"
    Then I should see "Current Timeslot Length: 60 minutes"
    And I should see "Reselect Duration"

  Scenario: Reselect Times
    Given a project of id "1" with date "Dec 1 2019" and time "Dec 1 2019 10:00 AM" and duration "60"
    Given I am on the times page for "Party 1"
    And I follow "Reselect Times"
    Then I should see "Current Timeslot Duration: Not set yet"
    Then I should not see "Start:"
