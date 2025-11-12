# GrowH - Habit Tracking Application

A Rails 8 application for tracking habits and personal growth.

## Features

- User authentication with Devise
- Habit creation and management
- Progress tracking
- Dashboard with streaks and statistics
- Modern UI with Tailwind CSS

## Getting Started

### Prerequisites

- Ruby 3.2.3
- Rails 8.0
- PostgreSQL (for production)
- SQLite3 (for development)

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   bundle install
   ```

3. Set up the database:
   ```bash
   rails db:create
   rails db:migrate
   ```

4. Start the server:
   ```bash
   rails server
   ```

## Deployment to Heroku

### Prerequisites
- Heroku CLI installed
- Git repository

### Steps

1. Create a Heroku app:
   ```bash
   heroku create your-app-name
   ```

2. Add PostgreSQL addon:
   ```bash
   heroku addons:create heroku-postgresql:mini
   ```

3. Set environment variables:
   ```bash
   heroku config:set SECRET_KEY_BASE=$(rails secret)
   heroku config:set RAILS_ENV=production
   heroku config:set RAILS_LOG_LEVEL=info
   ```

4. Deploy:
   ```bash
   git push heroku main
   ```

5. Run migrations:
   ```bash
   heroku run rails db:migrate
   ```

### Required Environment Variables

- `SECRET_KEY_BASE`: Rails secret key (generated automatically)
- `DATABASE_URL`: PostgreSQL database URL (set by Heroku)
- `RAILS_ENV`: Set to "production"
- `RAILS_LOG_LEVEL`: Log level (default: "info")

## Testing

Run the test suite:
```bash
bundle exec rspec
```

Run Cucumber features:
```bash
bundle exec cucumber
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request
