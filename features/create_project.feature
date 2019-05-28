Feature: create a project

  As a logged in user
  So that I can have multiple projects
  I can create a new project

  Background: user is logged in
    Given a user with the email "lawrencechen14@berkeley.edu" with password "password" and with username "lawrencechen14" exists
    And a registered user with the username "lawrencechen14" has a project named "Test Meeting 1"
    And a registered user with the username "lawrencechen14" has a project named "Test Meeting 2"
    And I am on the login page
    When I fill in "Email" with "lawrencechen14@berkeley.edu"
    And I fill in "Password" with "password"
    And I press "Log In"
    Then I should be on the projects page
    And I should see "lawrencechen14"

  Scenario: go to new project page and back
    When I follow "New Project"
    Then I should see "Enter name of new project"
    When I follow "Back"
    Then I should be on the projects page

  Scenario: successfully create a new project
    When I follow "New Project"
    Then I should see "Enter name of new project"
    When I fill in "Project Name" with "Test Meeting 3"
    And I press "Create Project"
    Then I should be on the projects page
    And I should see "Successfully created project Test Meeting 3"

  Scenario: give project duplicate project name
    When I follow "New Project"
    Then I should see "Enter name of new project"
    When I fill in "Project Name" with "Test Meeting 2"
    And I press "Create Project"
    Then I should see "Enter name of new project"
    And I should see "Project name already exists"

  Scenario: give project invalid name
    When I follow "New Project"
    Then I should see "Enter name of new project"
    When I fill in "Project Name" with ""
    And I press "Create Project"
    Then I should see "Enter name of new project"
    And I should see "Invalid project name"

  Scenario: rename project to same name
    When I am on the edit page for "Test Meeting 1"
    Then I should see "Renaming Project"
    When I fill in "New Project Name" with "Test Meeting 1"
    And I press "Confirm Renaming"
    Then I should see "Cannot rename to same project name"
