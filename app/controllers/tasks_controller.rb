class TasksController < ApplicationController
  before_action :require_login
  before_action :set_task, only: %i[show edit update destroy complete]

  SORT_OPTIONS = %w[due_date description priority].freeze

  def index
    @sort = SORT_OPTIONS.include?(params[:sort]) ? params[:sort] : "due_date"
    @task = current_user.tasks.new(due_date: Date.current, priority: 2)
    @tasks = current_user.tasks.ordered_by(@sort)
    @due_today_tasks = current_user.tasks.due_today.ordered_by("priority")
    @open_count = current_user.tasks.active.count
    @completed_count = current_user.tasks.where(completed: true).count
  end

  def show; end

  def edit; end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to tasks_path(sort: params[:sort]), notice: "Task added."
    else
      prepare_index_state
      flash.now[:alert] = "Please review the task details."
      render :index, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path(sort: params[:sort]), notice: "Task updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def complete
    @task.update!(completed: true)
    redirect_to tasks_path(sort: params[:sort]), notice: "Task completed."
  end

  def destroy
    @task.destroy!
    redirect_to tasks_path(sort: params[:sort]), notice: "Task deleted."
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end

  def task_params
    params.require(:task).permit(:description, :due_date, :priority)
  end

  def prepare_index_state
    @sort = SORT_OPTIONS.include?(params[:sort]) ? params[:sort] : "due_date"
    @tasks = current_user.tasks.ordered_by(@sort)
    @due_today_tasks = current_user.tasks.due_today.ordered_by("priority")
    @open_count = current_user.tasks.active.count
    @completed_count = current_user.tasks.where(completed: true).count
  end
end
