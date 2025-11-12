Given('I completed it for {int} days') do |days|
  days.times do |i|
    @habit.progress_logs.create!(
      logged_date: (days - i).days.ago.to_date,
      completed: true
    )
  end
end

Given('I skipped it yesterday') do
  @habit.progress_logs.find_or_create_by!(logged_date: 1.day.ago.to_date) do |log|
    log.completed = false
  end
end

When('I mark {string} as done today') do |habit_name|
  habit = @user.habits.find_by(title: habit_name)
  visit dashboard_path
  within(:xpath, "//h3[contains(text(), '#{habit_name}')]/ancestor::div[contains(@class, 'bg-white')]") do
    click_button 'Done'
  end
end

Then('my total completions should increase') do
  expect(page).to have_content('Completed:')
end

When('I mark {string} as done') do |habit_name|
  visit dashboard_path
  within(:xpath, "//h3[contains(text(), '#{habit_name}')]/ancestor::div[contains(@class, 'bg-white')]") do
    click_button 'Done'
  end
end

Then('both habits should show as completed') do
  expect(page).to have_content('Completed today', count: 2)
end

Then('I should see a motivational quote') do
  expect(page).to have_selector('.text-2xl.font-light.italic')
end