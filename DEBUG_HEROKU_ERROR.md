# How to Debug Heroku Crash (H10 Error)

## Error You're Seeing:
```
heroku[web.1]: Process exited with status 1
State changed from starting to crashed
code=H10 desc="App crashed"
```

This means the app is crashing during startup. We need to see WHY.

## Step 1: Check Detailed Logs

### If you have Heroku CLI installed:

Run this command in your terminal:

```bash
heroku logs --tail --app test1231
```

This will show you the detailed error messages.

### If you DON'T have Heroku CLI installed:

Go to Heroku Dashboard → Your App → Click on the "More" menu (three dots) → Click "View logs"

## Step 2: Common Causes and Solutions

### Cause 1: Missing Environment Variables

**Error might look like:**
- `RAILS_MASTER_KEY` missing
- `SECRET_KEY_BASE` missing

**Solution:**
Make sure you've added all 3 config vars in the Heroku dashboard:
1. Go to: https://dashboard.heroku.com/apps/test1231/settings
2. Under "Config Vars", check you have:
   - `RAILS_MASTER_KEY`
   - `RAILS_ENV` = `production`
   - `SECRET_KEY_BASE`

### Cause 2: Database Issues

**Error might look like:**
- `relation "schema_migrations" does not exist`
- PostgreSQL connection errors

**Solution:**
Run migrations:
1. In Heroku dashboard → "More" menu → "Run console"
2. Type: `rails db:migrate`
3. Press Enter

### Cause 3: Buildpack Issues

**Error might look like:**
- Build failed
- Gem installation errors

**Solution:**
Check buildpack in Heroku dashboard:
1. Settings → Buildpacks
2. Should have: `heroku/ruby`

### Cause 4: Procfile Errors

**Solution:**
Check if Procfile is correct. It should contain:
```
web: bundle exec rails server -p $PORT
release: bundle exec rails db:migrate
```

## Step 3: Share the Full Logs

After running `heroku logs --tail`, copy and paste the FULL output here so I can see what's causing the crash.

The logs should show something like:
- What command is being run
- What error is occurring
- Where in the code the error happens

## Quick Commands to Try

Once you have the Heroku CLI installed (or access it via dashboard):

```bash
# View recent logs
heroku logs --tail --app test1231

# Check config vars
heroku config --app test1231

# Check dynos
heroku ps --app test1231

# Restart dynos (sometimes helps)
heroku restart --app test1231
```

## Most Likely Issue

Based on your previous errors, it's probably:

1. **Missing or incorrect RAILS_MASTER_KEY** - Make sure it's set correctly
2. **Credentials file issues** - The credentials file might not be compatible with the master key

Let's see those logs first!
