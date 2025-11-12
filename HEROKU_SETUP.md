# Heroku Deployment Setup Guide

## Recent Fixes Applied
I've fixed the following issues in your codebase:

1. ✅ Removed hardcoded `secret_key_base` in `config/environments/production.rb`
2. ✅ Added `release` script to Procfile for automatic database migrations
3. ✅ Created new master key for credentials

## Step 1: Install Heroku CLI (if not already installed)

```bash
# On Ubuntu/Debian
curl https://cli-assets.heroku.com/install.sh | sh

# Or download from https://devcenter.heroku.com/articles/heroku-cli
```

## Step 2: Login to Heroku

```bash
heroku login
```

## Step 3: Set Heroku Environment Variables

Run these commands in your terminal (or use Heroku Dashboard):

```bash
# Ensure you're connected to the right Heroku app
heroku git:remote -a test1231

# Set the master key (from your local config/master.key file)
heroku config:set RAILS_MASTER_KEY=$(cat config/master.key) --app test1231

# Set a secure secret key base
heroku config:set SECRET_KEY_BASE=$(cd /path/to/growH && bin/rails secret) --app test1231

# Verify config variables
heroku config --app test1231
```

## Step 4: Deploy to Heroku

```bash
# Make sure you're in the project directory
cd ~/Applications/Projects/Jessica/Roni-GrowH-Repo/growH

# Check git status
git status

# Add the updated files
git add config/environments/production.rb Procfile HEROKU_SETUP.md
git add config/credentials.yml.enc config/master.key

# Commit the changes
git commit -m "Fix Heroku deployment: remove hardcoded secrets, add migration script"

# Push to Heroku
git push heroku main

# Or if your Heroku remote is named differently:
# git push heroku main:main
```

## Step 5: Verify Deployment

After deployment completes:

```bash
# Check if app is running
heroku ps --app test1231

# Check recent logs
heroku logs --tail --app test1231

# Open the app
heroku open --app test1231
```

## Alternative: If Master Key Approach Doesn't Work

If you still have issues with credentials, you can disable encrypted credentials for Heroku by creating a `config/credentials.yml` file in production:

```bash
# On Heroku, create a simple credentials file
heroku run bash --app test1231
# Then in the Heroku shell:
echo "production:\n  secret_key_base: your-secret-key-here" > config/credentials.yml
```

Or better yet, just use ENV variables:

1. Remove the encrypted credentials dependency
2. Use environment variables directly

## Quick Diagnosis

To check what's happening on Heroku:

```bash
# Check config vars
heroku config --app test1231

# Check if the app is running
heroku ps --app test1231

# View recent logs
heroku logs --tail --app test1231

# Open the app in browser
heroku open --app test1231
```

## Common Issues

1. **R510 Uninitialized constant error**: Missing environment variables
2. **Application Error**: Check logs with `heroku logs --tail`
3. **Database errors**: Ensure migrations have run
4. **Credential errors**: Make sure RAILS_MASTER_KEY is set correctly
