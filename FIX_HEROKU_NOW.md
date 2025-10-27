# Fix Heroku Error - Step by Step

## Your Error:
```
code=H10 desc="App crashed"
```

## The Problem:
The app is crashing during startup, likely because the release command is failing.

## Quick Fix (2 Steps):

### Step 1: Update the Release Command

I've updated your `Procfile` to be more resilient. Now you need to:

1. Commit the change:
   ```bash
   git add Procfile
   git commit -m "Fix release command"
   git push origin main
   ```

2. Push to Heroku:
   - Go to https://dashboard.heroku.com/apps/test1231/deploy
   - Under "Manual deploy", select "main" branch
   - Click "Deploy Branch"

### Step 2: Make Sure Config Vars Are Set

Go to: https://dashboard.heroku.com/apps/test1231/settings

Scroll to **Config Vars** section and verify you have these 3 variables:

1. **RAILS_MASTER_KEY** = `693500a6a8ce510a1ebcaae526cc47e7bb40cd0efd50621fb06fdefbf260e284`
2. **RAILS_ENV** = `production`  
3. **SECRET_KEY_BASE** = `64ecef7631ed698ba3d590a0a53fafb1fa8fa3c56d27b370d925fc17aa9e035d1e20eb84a47de6e4642c3a6f2223ff9f629624573b77b071a19baa7fe9af6cd4`

If ANY are missing, add them.

## After Deployment:

1. Go to **More** menu → **Run console**
2. Type: `rails db:migrate`
3. Press Enter
4. Wait for it to finish
5. Go back to **Overview** tab
6. Click **Open app**

## If It Still Crashes:

Check the logs to see the actual error:

1. In Heroku Dashboard → **More** menu → **View logs**
2. Look for the actual error message
3. Share it with me

The logs will show you exactly what's failing.

## Alternative: Skip Release Command Entirely

If the release command keeps failing, we can remove it from Procfile:

Edit `Procfile` to just:
```
web: bundle exec rails server -p $PORT
```

Then manually run migrations in the console after deploy.
