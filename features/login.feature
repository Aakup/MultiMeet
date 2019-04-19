Feature: Login
  
    As a new user
    I want to login with my info
    So that I can access my projects
    
    Scenario: User is not logged in
        Given no current user
        When I access the landing page
        And I follow "login"
        Then I should be on the login page
        
    Scenario: User enters wrong password
        Given a registered user with the email "daniel@example.com" with password "password" exists
        And I am on the login page
        When I fill in "Email" with "daniel@example.com"
        And I fill in "Password" with "hello"
        And I press "Log In"
        Then I should be on the login page
        And I should see "Login information is wrong."
        
    Scenario: User enters correct info and reaches projects page
        Given a registered user with the email "daniellee0228@berkeley.edu" with password "password" exists
        And I am on the login page
        When I fill in "Email" with "daniellee0228@berkeley.edu"
        And I fill in "Password" with "password"
        And I press "Log In"
        Then I should be on the projects page
        And I should see "You have successfully logged in."
        And I should see "Log Out"
        And I should not see "Log In"
        And I should not see "Sign Up"

    Scenario: User is not logged in and tries to access a project's details
        Given no current user
        When I go to the URL "/projects/1/times"
        Then I should see "You must be logged in to perform that action"
        When I go to the URL "/projects/1/participants"
        Then I should see "You must be logged in to perform that action"
        When I go to the URL "/projects/1/matching"
        Then I should see "You must be logged in to perform that action"

