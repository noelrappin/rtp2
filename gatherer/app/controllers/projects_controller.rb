class ProjectsController < ApplicationController

  ##START: index
  def index
    @projects = Project.all
  end
  ##END: index

  def new
    @project = Project.new
  end

  ##START: create
  def create
    @action = CreatesProject.new(
      name: params[:project][:name],
      task_string: params[:project][:tasks] || "")
    success = @action.create
    if success
      redirect_to projects_path
    else
      @project = @action.project
      render :new
    end
  end
  ##END: create
end
