Feature: Create Habit
  As a user
  I want to create new habits
  So I can track things I want to do daily

  Background:
    Given I am a signed in user

  Scenario: Create a new habit successfully
    When I visit the new habit page
    And I fill in "Habit Name" with "Morning Exercise"
    And I fill in "Description" with "30 minutes of exercise"
    And I click "Create Habit"
    Then I should see "Habit created successfully"
    And I should see "Morning Exercise"

  Scenario: Create habit without title
    When I visit the new habit page
    And I click "Create Habit"
    Then I should see an error message