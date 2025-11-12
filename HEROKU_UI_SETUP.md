# Deploy to Heroku Using the Web UI

This guide walks you through deploying your Rails app to Heroku using the web interface.

## Step 1: Access Heroku Dashboard

1. Go to https://dashboard.heroku.com
2. Login with your Heroku account

## Step 2: Connect Your Repository

### Option A: If you already have a Heroku app (test1231)

1. Go to https://dashboard.heroku.com/apps/test1231
2. Click on the **Settings** tab
3. Scroll down to **Heroku Git URL**
4. Make sure your local git is connected to this Heroku app:
   ```bash
   # In your terminal
   cd ~/Applications/Projects/Jessica/Roni-GrowH-Repo/growH
   git remote -v  # Check if heroku remote exists
   ```

### Option B: Connect via GitHub

1. Go to your Heroku app (test1231)
2. Click on the **Deploy** tab
3. Under **Deployment method**, click **Connect to GitHub**
4. Authorize Heroku to access your GitHub account
5. Search for your repository: `your-username/growH`
6. Click **Connect**

## Step 3: Set Environment Variables (REQUIRED)

This is the most important step!

1. Go to your Heroku app dashboard
2. Click on the **Settings** tab
3. Scroll down to **Config Vars**
4. Click **Reveal Config Vars**

### Add these config vars:

| Key | Value | How to Get |
|-----|-------|------------|
| `RAILS_MASTER_KEY` | `4fb59b092703ed15dbe626abcc3bf248` | From your local `config/master.key` file |
| `RAILS_ENV` | `production` | - |
| `SECRET_KEY_BASE` | Generate using: `rails secret` | Run locally: `cd /path/to/growH && bin/rails secret` |

**Important Steps to Get Values:**

1. **Get RAILS_MASTER_KEY** - In your terminal:
   ```bash
   cd ~/Applications/Projects/Jessica/Roni-GrowH-Repo/growH
   cat config/master.key
   ```
   Copy the entire string and paste it as the value for `RAILS_MASTER_KEY`

2. **Get SECRET_KEY_BASE** - In your terminal:
   ```bash
   cd ~/Applications/Projects/Jessica/Roni-GrowH-Repo/growH
   bin/rails secret
   ```
   Copy the output and paste it as the value for `SECRET_KEY_BASE`

### To Add Each Config Var:

1. In the Heroku dashboard, under Config Vars section
2. Click **Add** next to "Reveal Config Vars"
3. Enter the KEY name
4. Enter the VALUE
5. Click **Add** button
6. Repeat for each config var

## Step 4: Deploy Your App

### Option A: Manual Deploy

1. Go to the **Deploy** tab
2. Under **Manual deploy**, select branch: `main`
3. Click **Deploy Branch**
4. Wait for the build to complete

### Option B: Automatic Deploy (Recommended)

1. Go to the **Deploy** tab
2. Under **Automatic deploys from GitHub**, select branch: `main`
3. Click **Enable Automatic Deploys**
4. Now every time you push to GitHub, Heroku will automatically deploy

## Step 5: Run Database Migrations

After deployment:

1. Go to the **More** menu (three dots) in the top right
2. Click **Run console**
3. In the console, type:
   ```
   rails db:migrate
   ```
4. Press Enter
5. Wait for migrations to complete

## Step 6: Verify Your App is Running

1. Go to the **Overview** tab
2. You should see a "web" dyno running
3. Click **Open app** button to view your deployed app

## Troubleshooting

### Check Logs

If something goes wrong:

1. Go to the **More** menu
2. Click **View logs**
3. Look for error messages

### Common Issues

**Issue: "Application Error"**
- Check that all config vars are set correctly
- Make sure `RAILS_MASTER_KEY` matches your local `config/master.key`
- Verify database migrations have run

**Issue: "H10 - App crashed"**
- Check logs for specific errors
- Ensure all environment variables are set
- Verify database connection

**Issue: Credentials error**
- Make sure `RAILS_MASTER_KEY` is set exactly as it appears in `config/master.key`
- Make sure `SECRET_KEY_BASE` is set

### View Running Processes

1. Go to the **Overview** tab
2. You should see "web" dyno with a green indicator

### Restart Dynos

If the app is acting strange:
1. Go to **More** menu
2. Click **Restart all dynos**

## Quick Reference

### To Push Changes:

1. Make changes locally
2. Commit changes:
   ```bash
   git add .
   git commit -m "Your changes"
   git push origin main
   ```
3. If auto-deploy is enabled, Heroku deploys automatically
4. Otherwise, go to Heroku dashboard → Deploy tab → Deploy Branch

### To View Your App:

Visit: https://test1231-24b289936bff.herokuapp.com

### To Access Rails Console:

1. Heroku dashboard → **More** menu → **Run console**
2. Or use terminal:
   ```bash
   heroku run rails console --app test1231
   ```

## Next Steps After Deployment

1. ✅ Verify the app loads without errors
2. ✅ Test user registration
3. ✅ Create a test habit
4. ✅ Check that the database is working
5. ✅ Verify all pages load correctly

## Important Files to Commit

Make sure these files are committed and pushed to GitHub:

- `config/credentials.yml.enc` - Encrypted credentials
- `Procfile` - Process configuration
- `config/environments/production.rb` - Production settings
- `Gemfile` and `Gemfile.lock` - Dependencies
- All other application files

## Database

Your app uses PostgreSQL on Heroku (automatically set up by Heroku). The `DATABASE_URL` is automatically configured by Heroku, so you don't need to set it manually.

Good luck with your deployment! 🚀
