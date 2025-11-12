# GrowH - Build Better Habits

A simple habit tracking app that helps you build and maintain daily habits through streak tracking and positive encouragement.

## Team Members
- [Your Name] - [Your ID]
- [Member 2 Name] - [Member 2 ID]
- [Member 3 Name] - [Member 3 ID]

## What It Does
GrowH lets you create daily habits, track your progress, and build streaks. It's designed to be simple and encouraging rather than overwhelming.

## Setup Instructions

### Prerequisites
- Ruby 3.2+
- Rails 8.0+
- SQLite3

### Installation (Local)
```bash
# Clone the repo
git clone https://github.com/mch2214/growh-project
cd growh-project

# Install dependencies
bundle install

export RAILS_ENV=test
unset DATABASE_URL
./bin/rails db:prepare

# Run the app
./bin/rails server
```

Visit `http://localhost:3000`

## Running Tests

### Run RSpec tests (TEST env)
```bash
export RAILS_ENV=test
unset DATABASE_URL
bundle exec rspec
```

### Run Cucumber tests (TEST env)
```bash
export RAILS_ENV=test
unset DATABASE_URL
bundle exec cucumber
```

### Notes
- Always use `./bin/rails` or `bundle exec rails` to ensure the app uses the bundled gems.
- Do not install system `rails`; use the binstub provided by the project.
- Production on Heroku uses PostgreSQL via `ENV["DATABASE_URL"]`. Local development/tests use SQLite.

## Features
- User authentication
- Create and manage habits
- Daily progress tracking
- Streak calculation
- Motivational quotes
- Progress statistics

### User Stories (Cucumber Features)

These executable user stories are defined under `features/` and can be run with Cucumber.

- Create Habit (`features/create_habit.feature`):
  - I can create a new habit with name and description.
  - A habit cannot be created without passing the validation check for title. 

- Track Daily Progress (`features/track_progress.feature`):
  - I can mark a habit as done or skipped from the dashboard.
  - I receive feedback like "Progress logged" and see status such as "Completed today".

- View Streaks (`features/view_streaks.feature`):
  - I can view my current streak on the dashboard.
  - Habit details show the day streak and history. 

## Test Inventory

This section enumerates all tests (RSpec and Cucumber) by file, with example/scenario names and purpose.

### RSpec (Unit/Model tests)

- `spec/models/user_spec.rb`
  - describe associations
    - it "has many habits" - verifies `User` -> `has_many :habits`.
  - describe validations
    - it "is valid with valid attributes" - email/password present.
    - it "is not valid without email" - requires email.

- `spec/models/habit_spec.rb`
  - describe associations
    - it "belongs to user" - verifies `Habit` -> `belongs_to :user`.
    - it "has many progress logs" - verifies `Habit` -> `has_many :progress_logs`.
  - describe validations
    - it "is valid with title and user" - presence of title with owner.
    - it "is not valid without title" - title required.
  - describe `#current_streak`
    - it "returns 0 when no logs exist" - base case.
    - it "calculates consecutive days correctly" - counts continuous `completed: true` logs.
  - describe `#total_completions`
    - it "counts completed logs" - sums only completed entries.

- `spec/models/progress_log_spec.rb`
  - describe associations
    - it "belongs to habit" - verifies `ProgressLog` -> `belongs_to :habit`.
  - describe validations
    - it "is valid with habit and date" - requires `habit` and `logged_date`.
    - it "is not valid without logged_date" - date required.
    - it "prevents duplicate logs for same date" - uniqueness per habit/date.

### Cucumber (Features/Scenarios)

- `features/create_habit.feature` - Create Habit
  - Scenario: "Create a new habit successfully" - fills name/description, submits, sees success and habit name.
  - Scenario: "Create habit without title" - submits blank form, sees validation error.

- `features/track_progress.feature` - Track Daily Progress
  - Scenario: "Mark habit as done" - from dashboard, clicks Done for a habit, sees confirmation and status.
  - Scenario: "Mark habit as skipped" - from dashboard, clicks Skip, sees confirmation and status.

- `features/view_streaks.feature` - View Streaks
  - Scenario: "View current streak" - dashboard shows current day streak.
  - Scenario: "View habit details" - habit show page lists Day Streak and completion history.

### Step Definitions

Implemented in `features/step_definitions/habit_steps.rb`:

- Given "I am a signed in user"
- Given "I have a habit called {string}"
- Given "I have completed it for {int} days in a row"
- When "I visit the new habit page"
- When "I visit the dashboard"
- When "I visit the habit details page"
- When "I fill in {string} with {string}"
- When "I click {string}"
- When "I click {string} for {string}"
- Then "I should see {string}"
- Then "I should see an error message"
- Then "I should see my completion history"

## Deployment
Deployed on Heroku: growh-project-ddc0c0f9238c.herokuapp.com

## Technologies
- Ruby on Rails
- Postgres Heroku
- Devise (authentication)
- Tailwind CSS