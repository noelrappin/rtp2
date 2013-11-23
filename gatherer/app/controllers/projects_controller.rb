class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  ##START: create
  def create
    @action = CreatesProject.new(
      name: params[:project][:name],
      task_string: params[:project][:tasks])
    @action.create
    redirect_to projects_path
  end
  ##END: create
end
