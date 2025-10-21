require 'rails_helper'

RSpec.describe Habit, type: :model do
  let(:user) { User.create!(email: 'test@example.com', password: 'password123') }
  
  describe 'associations' do
    it 'belongs to user' do
      association = Habit.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'has many progress logs' do
      association = Habit.reflect_on_association(:progress_logs)
      expect(association.macro).to eq :has_many
    end
  end

  describe 'validations' do
    it 'is valid with title and user' do
      habit = user.habits.build(title: 'Exercise')
      expect(habit).to be_valid
    end

    it 'is not valid without title' do
      habit = user.habits.build(description: 'Test')
      expect(habit).to_not be_valid
    end
  end

  describe '#current_streak' do
    it 'returns 0 when no logs exist' do
      habit = user.habits.create!(title: 'Test')
      expect(habit.current_streak).to eq(0)
    end

    it 'calculates consecutive days correctly' do
      habit = user.habits.create!(title: 'Test')
      3.times do |i|
        habit.progress_logs.create!(
          logged_date: i.days.ago.to_date,
          completed: true
        )
      end
      expect(habit.current_streak).to eq(3)
    end
  end

  describe '#total_completions' do
    it 'counts completed logs' do
      habit = user.habits.create!(title: 'Test')
      habit.progress_logs.create!(logged_date: Date.today, completed: true)
      habit.progress_logs.create!(logged_date: 1.day.ago, completed: false)
      expect(habit.total_completions).to eq(1)
    end
  end
end