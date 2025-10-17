class ProgressLogsController < ApplicationController
  def create
    @habit = current_user.habits.find(params[:habit_id])
    @progress_log = @habit.progress_logs.find_or_initialize_by(logged_date: Date.today)
    
    @progress_log.completed = params[:completed] == "true"
    
    if @progress_log.save
      redirect_to dashboard_path, notice: "Progress logged!"
    else
      redirect_to dashboard_path, alert: "Error logging progress."
    end
  end
end