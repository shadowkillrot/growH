# Clear existing data
ProgressLog.destroy_all
Habit.destroy_all
User.destroy_all

# Create a test user
user = User.create!(
  email: "demo@growh.com",
  password: "password123",
  password_confirmation: "password123"
)

# Create sample habits
habits = [
  { title: "Morning Exercise", description: "30 minutes of exercise" },
  { title: "Read Daily", description: "Read at least 10 pages" },
  { title: "Drink Water", description: "Drink 8 glasses of water" },
  { title: "Meditation", description: "10 minutes of mindfulness" }
]

habits.each do |habit_data|
  habit = user.habits.create!(habit_data)
  
  # Create some progress logs
  (1..7).each do |days_ago|
    habit.progress_logs.create!(
      logged_date: days_ago.days.ago.to_date,
      completed: [true, true, true, false].sample
    )
  end
end

puts "Seeded #{User.count} users, #{Habit.count} habits, and #{ProgressLog.count} progress logs"