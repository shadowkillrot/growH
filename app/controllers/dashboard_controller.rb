class DashboardController < ApplicationController
  def index
    @habits = current_user.habits.order(created_at: :desc)
    @motivational_quotes = [
      "Small steps every day lead to big changes.",
      "Progress, not perfection.",
      "You're building something great, one day at a time.",
      "Consistency is the key to transformation.",
      "Every day is a fresh start.",
      "Believe in the power of small habits.",
      "You showed up today—that's what matters.",
      "Keep going, you're doing amazing!",
      "Success is the sum of small efforts repeated daily.",
      "Your future self will thank you for today's effort."
    ]
    @quote = @motivational_quotes.sample
  end
end