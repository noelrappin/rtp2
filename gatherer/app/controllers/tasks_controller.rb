class TasksController < ApplicationController

  def update
    @task = Task.find(params[:id])
    completed = params[:task].delete(:completed)
    params[:task][:completed_at] = Time.current if completed
    if @task.update_attributes(params[:task].permit(:size, :completed_at))
      TaskMailer.task_completed_email(@task).deliver if completed
      redirect_to @task, notice: "'project was successfully updated.'"
    else
      render action: 'edit'
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  ##START: create
  def create
    @task = Task.new(
        params[:task].permit(:project_id, :title, :size))
    redirect_to @task.project
  end
  ##END: create
end
