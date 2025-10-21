Feature: Track Daily Progress
  As a user
  I want to log my daily progress
  So I can track if I completed my habits

  Background:
    Given I am a signed in user
    And I have a habit called "Reading"

  Scenario: Mark habit as done
    When I visit the dashboard
    And I click "Done" for "Reading"
    Then I should see "Progress logged"
    And I should see "Completed today"

  Scenario: Mark habit as skipped
    When I visit the dashboard
    And I click "Skip" for "Reading"
    Then I should see "Progress logged"
    And I should see "Marked as not done"