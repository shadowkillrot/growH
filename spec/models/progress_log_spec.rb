require 'rails_helper'

RSpec.describe ProgressLog, type: :model do
  let(:user) { User.create!(email: 'test@example.com', password: 'password123') }
  let(:habit) { user.habits.create!(title: 'Exercise') }

  describe 'associations' do
    it 'belongs to habit' do
      association = ProgressLog.reflect_on_association(:habit)
      expect(association.macro).to eq :belongs_to
    end
  end

  describe 'validations' do
    it 'is valid with habit and date' do
      log = habit.progress_logs.build(logged_date: Date.today, completed: true)
      expect(log).to be_valid
    end

    it 'is not valid without logged_date' do
      log = habit.progress_logs.build(completed: true)
      expect(log).to_not be_valid
    end

    it 'prevents duplicate logs for same date' do
      habit.progress_logs.create!(logged_date: Date.today, completed: true)
      duplicate = habit.progress_logs.build(logged_date: Date.today, completed: false)
      expect(duplicate).to_not be_valid
    end
  end
end