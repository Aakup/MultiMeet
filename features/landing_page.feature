Feature: see landing page

  As any type of user
  So that I can access MultiMatch
  I want to see the landing page

  Background: user not logged in

  Scenario: visit landing page
    When I go to the home page
    Then I should see "MultiMeet"
