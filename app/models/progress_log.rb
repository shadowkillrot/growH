class ProgressLog < ApplicationRecord
  belongs_to :habit
  
  validates :logged_date, presence: true, uniqueness: { scope: :habit_id }
  validates :completed, inclusion: { in: [true, false] }
  
  scope :completed, -> { where(completed: true) }
  scope :recent, -> { order(logged_date: :desc) }
end