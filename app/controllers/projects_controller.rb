class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit]

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1
  # GET /projects/1.json
  # def show
  #   # unless current_user
  #   #   redirect_to root_path
  #   # end
  # end
  #
  # # GET /times/1/edit
  # def edit
  #
  # end

  def update
    @project = Project.find(params[:id].to_i)
    @project.project_name = project_params[:project_name]
    if @project.save!
      redirect_to projects_path
    end
  end

  # returns true if ok, false if not
  def valid_project_name?(project_name)
    if project_name.nil? or project_name.empty?
      flash[:message] = "Invalid project name"
      return false
    elsif !Project.where(
        project_name: project_name, user_id: @project.user_id).blank?
      flash[:message] = "Project name already exists"
      return false
    end
    true
  end

  def create
    @project = current_user.projects.new(project_params)
    project_name = @project.project_name

    unless valid_project_name? project_name
      redirect_to new_project_path and return
    end

    if @project.save!
      if params[:commit] == "Create Project and Choose Times"
        flash[:success] = "Successfully created project #{project_name}. Choose dates and times now!"
        redirect_to new_project_time_path(@project)
      else
        flash[:success] = "Successfully created project #{project_name}"
        redirect_to projects_path
      end
    # else
    #   flash[:message] = @user.errors.full_messages
    #   redirect_to projects_path
    end
  end

  # GET /times
  # GET /times.json
  def index
    @user = current_user
    if @user
      @projects = @user.projects # Project.where(user_id: @user.id)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      # print(params)
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:project_name)
    end
end
