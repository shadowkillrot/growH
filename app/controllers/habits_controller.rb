class HabitsController < ApplicationController
  before_action :set_habit, only: [:show, :edit, :update, :destroy]
  
  def index
    @habits = current_user.habits.order(created_at: :desc)
  end
  
  def show
    @progress_logs = @habit.progress_logs.recent.limit(30)
  end
  
  def new
    @habit = current_user.habits.build
  end
  
  def create
    @habit = current_user.habits.build(habit_params)
    
    if @habit.save
      redirect_to dashboard_path, notice: "Habit created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end
  
  def update
    if @habit.update(habit_params)
      redirect_to @habit, notice: "Habit updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @habit.destroy
    redirect_to dashboard_path, notice: "Habit deleted successfully!"
  end
  
  private
  
  def set_habit
    @habit = current_user.habits.find(params[:id])
  end
  
  def habit_params
    params.require(:habit).permit(:title, :description)
  end
end