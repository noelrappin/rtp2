class ProjectsController < ApplicationController

  def index
    @projects = ProjectPresenter.from_project_list(Project.all)
  end

  def new
    @project = Project.new
  end

  ##START: show
  def show
    @project = Project.find(params[:id])
  end
  ##END: show

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

  ##START: update
  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to @project, notice: "'project was successfully updated.'"
    else
      render action: 'edit'
    end
  end
  ##END: update
end
