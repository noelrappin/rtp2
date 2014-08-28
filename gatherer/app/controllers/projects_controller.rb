class ProjectsController < ApplicationController

  def index
    @projects = ProjectPresenter.from_project_list(current_user.visible_projects)
  end

  def new
    @project = Project.new
  end

  ##START: show
  def show
    @project = Project.find(params[:id])
    unless current_user.can_view?(@project)
      redirect_to new_user_session_path
      return
    end
  end
  ##END: show

  def create
    @action = CreatesProject.new(
      name: params[:project][:name],
      task_string: params[:project][:tasks] || "",
      users: [current_user])
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
    if params[:project] && @project.update_attributes(params[:project].permit(:name))
      redirect_to @project, notice: "'project was successfully updated.'"
    else
      render action: 'edit'
    end
  end
  ##END: update
end
