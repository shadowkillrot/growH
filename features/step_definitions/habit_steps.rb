Given('I am a signed in user') do
  @user = User.create!(email: 'test@example.com', password: 'password123')
  visit new_user_session_path
  fill_in 'Email', with: 'test@example.com'
  fill_in 'Password', with: 'password123'
  click_button 'Sign In'
end

Given('I have a habit called {string}') do |habit_name|
  @habit = @user.habits.create!(title: habit_name, description: 'Test habit')
end

Given('I have completed it for {int} days in a row') do |days|
  days.times do |i|
    @habit.progress_logs.create!(
      logged_date: (days - i).days.ago.to_date,
      completed: true
    )
  end
end

When('I visit the new habit page') do
  visit new_habit_path
end

When('I visit the dashboard') do
  visit dashboard_path
end

When('I visit the habit details page') do
  visit habit_path(@habit)
end

When('I fill in {string} with {string}') do |field, value|
  fill_in field, with: value
end

When('I click {string}') do |button|
  click_button button
end

When('I click {string} for {string}') do |button, habit_name|
  within(:xpath, "//h3[contains(text(), '#{habit_name}')]/ancestor::div[contains(@class, 'bg-white')]") do
    click_button button
  end
end

Then('I should see {string}') do |text|
  expect(page).to have_content(text)
end

Then('I should see an error message') do
  expect(page).to have_selector('.text-red-500')
end

Then('I should see my completion history') do
  expect(page).to have_content('Recent Progress')
end