require 'rails_helper'

RSpec.describe Habit, type: :model do
  let(:user) { User.create!(email: 'test@example.com', password: 'password123') }
  let(:habit) { user.habits.create!(title: 'Exercise', description: 'Daily workout') }
  
  describe 'associations' do
    it 'belongs to user' do
      association = Habit.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'has many progress logs' do
      association = Habit.reflect_on_association(:progress_logs)
      expect(association.macro).to eq :has_many
    end

    it 'destroys progress logs when destroyed' do
      habit.progress_logs.create!(logged_date: Date.today, completed: true)
      expect { habit.destroy }.to change(ProgressLog, :count).by(-1)
    end
  end

  describe 'validations' do
    it 'is valid with title and user' do
      expect(habit).to be_valid
    end

    it 'is not valid without title' do
      habit = user.habits.build(description: 'Test')
      expect(habit).to_not be_valid
    end

    it 'is not valid without user' do
      habit = Habit.new(title: 'Test')
      expect(habit).to_not be_valid
    end
  end

  describe '#current_streak' do
    it 'returns 0 when no logs exist' do
      expect(habit.current_streak).to eq(0)
    end

    it 'calculates consecutive days correctly' do
      3.times do |i|
        habit.progress_logs.create!(
          logged_date: i.days.ago.to_date,
          completed: true
        )
      end
      expect(habit.current_streak).to eq(3)
    end

    it 'stops counting at first incomplete day' do
      habit.progress_logs.create!(logged_date: Date.today, completed: true)
      habit.progress_logs.create!(logged_date: 1.day.ago, completed: false)
      habit.progress_logs.create!(logged_date: 2.days.ago, completed: true)
      
      expect(habit.current_streak).to eq(1)
    end

    it 'resets when streak is broken' do
      habit.progress_logs.create!(logged_date: Date.today, completed: true)
      habit.progress_logs.create!(logged_date: 2.days.ago, completed: true)
      
      expect(habit.current_streak).to eq(1)
    end
  end

  describe '#total_completions' do
    it 'counts only completed logs' do
      habit.progress_logs.create!(logged_date: Date.today, completed: true)
      habit.progress_logs.create!(logged_date: 1.day.ago, completed: false)
      habit.progress_logs.create!(logged_date: 2.days.ago, completed: true)
      
      expect(habit.total_completions).to eq(2)
    end

    it 'returns 0 when no completions' do
      habit.progress_logs.create!(logged_date: Date.today, completed: false)
      expect(habit.total_completions).to eq(0)
    end

    it 'handles empty progress logs' do
      expect(habit.total_completions).to eq(0)
    end
  end

  describe '#completion_rate' do
    it 'calculates percentage correctly' do
      5.times { |i| habit.progress_logs.create!(logged_date: i.days.ago, completed: true) }
      5.times { |i| habit.progress_logs.create!(logged_date: (i+5).days.ago, completed: false) }
      
      expect(habit.completion_rate).to eq(50.0)
    end

    it 'returns 0 when no logs exist' do
      expect(habit.completion_rate).to eq(0)
    end

    it 'returns 100 when all completed' do
      3.times { |i| habit.progress_logs.create!(logged_date: i.days.ago, completed: true) }
      expect(habit.completion_rate).to eq(100.0)
    end

    it 'rounds to one decimal place' do
      habit.progress_logs.create!(logged_date: Date.today, completed: true)
      habit.progress_logs.create!(logged_date: 1.day.ago, completed: true)
      habit.progress_logs.create!(logged_date: 2.days.ago, completed: false)
      
      expect(habit.completion_rate).to eq(66.7)
    end

    it 'handles zero logs' do
      expect(habit.completion_rate).to eq(0)
    end
  end

  describe '#logged_today?' do
    it 'returns true when logged today' do
      habit.progress_logs.create!(logged_date: Date.today, completed: true)
      expect(habit.logged_today?).to be true
    end

    it 'returns false when not logged today' do
      habit.progress_logs.create!(logged_date: 1.day.ago, completed: true)
      expect(habit.logged_today?).to be false
    end

    it 'returns true even if marked as incomplete' do
      habit.progress_logs.create!(logged_date: Date.today, completed: false)
      expect(habit.logged_today?).to be true
    end

    it 'handles no logs' do
      expect(habit.logged_today?).to be false
    end
  end

  describe '#completed_today?' do
    it 'returns true when completed today' do
      habit.progress_logs.create!(logged_date: Date.today, completed: true)
      expect(habit.completed_today?).to be true
    end

    it 'returns false when not completed today' do
      habit.progress_logs.create!(logged_date: Date.today, completed: false)
      expect(habit.completed_today?).to be false
    end

    it 'returns false when not logged today' do
      expect(habit.completed_today?).to be false
    end

    it 'returns false when only logged yesterday' do
      habit.progress_logs.create!(logged_date: 1.day.ago, completed: true)
      expect(habit.completed_today?).to be false
    end
  end
end