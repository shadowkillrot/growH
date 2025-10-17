class Habit < ApplicationRecord
  belongs_to :user
  has_many :progress_logs, dependent: :destroy
  
  validates :title, presence: true
  
  def current_streak
    return 0 if progress_logs.empty?
    
    streak = 0
    date = Date.today
    
    while progress_logs.where(logged_date: date, completed: true).exists?
      streak += 1
      date -= 1.day
    end
    
    streak
  end
  
  def total_completions
    progress_logs.where(completed: true).count
  end
  
  def completion_rate
    total = progress_logs.count
    return 0 if total.zero?
    
    ((total_completions.to_f / total) * 100).round(1)
  end
  
  def logged_today?
    progress_logs.exists?(logged_date: Date.today)
  end
  
  def completed_today?
    progress_logs.exists?(logged_date: Date.today, completed: true)
  end
end