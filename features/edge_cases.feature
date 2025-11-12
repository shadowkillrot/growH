Feature: Edge Cases and Advanced Functionality
  As a user
  I want the app to handle various scenarios correctly
  So I can rely on accurate tracking

  Background:
    Given I am a signed in user

  Scenario: Broken streak recovery
    Given I have a habit called "Exercise"
    And I completed it for 3 days
    And I skipped it yesterday
    When I visit the dashboard
    And I mark "Exercise" as done today
    Then my total completions should increase

  Scenario: Multiple habits tracking
    Given I have a habit called "Reading"
    And I have a habit called "Meditation"
    When I visit the dashboard
    And I mark "Reading" as done
    And I mark "Meditation" as done
    Then both habits should show as completed

  Scenario: View motivational quotes
    When I visit the dashboard
    Then I should see a motivational quote