Feature: View Streaks
  As a user
  I want to see my habit streaks
  So I can track my consistency

  Background:
    Given I am a signed in user
    And I have a habit called "Meditation"
    And I have completed it for 5 days in a row

  Scenario: View current streak
    When I visit the dashboard
    Then I should see "day streak"

  Scenario: View habit details
    When I visit the habit details page
    Then I should see "Day Streak"
    And I should see my completion history