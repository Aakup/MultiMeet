# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, :require_user, :ensure_owner_logged_in, only: %i[show edit]
  helper_method :calc_responded

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1
  # GET /projects/1.json
  def show

  end

  # GET /times/1/edit
  # def edit
  #
  # end

  def ensure_owner_logged_in
    unless !logged_in? or Project.where(user_id: current_user.id).ids.include? params[:id].to_i
      flash[:danger] = 'Access denied.'
      redirect_to projects_path
    end
  end

  def update
    @project = Project.find(params[:id].to_i)
    new_project_name = project_params[:project_name]

    if valid_renaming? new_project_name
      @project.update(project_name: new_project_name)
      flash[:success] = "Successfully renamed project to #{new_project_name}"
      redirect_to project_path(@project)
    else
      redirect_to edit_project_path(@project)
    end
  end

  # returns true if ok, false if not
  def valid_project_name?(project_name)
    if project_name.nil? || project_name.empty?
      flash[:danger] = 'Invalid project name'
      return false
    elsif !Project.where(
      project_name: project_name, user_id: @project.user_id
    ).blank?
      flash[:danger] = 'Project name already exists'
      return false
    end
    true
  end

  def valid_renaming?(project_name)
    if @project.project_name == project_name
      flash[:danger] = 'Cannot rename to same project name'
      return false
    end
    valid_project_name? project_name
  end

  def redirect_based_on_create_type(project_name)
    if params[:commit] == 'Choose Times'
      flash[:success] = "Successfully created project #{project_name}. Choose dates and times now!"
      redirect_to new_project_time_path(@project)
    else
      flash[:success] = "Successfully created project #{project_name}"
      redirect_to projects_path
    end
  end

  def create
    @project = current_user.projects.new(project_params)
    project_name = @project.project_name

    unless valid_project_name? project_name
      redirect_to(new_project_path) && return
    end

    if @project.save!
      redirect_based_on_create_type(project_name)
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

      @num_responded = {}
      @responded_fraction = {}
      @user.projects.each do |project|
        calc_responded project.id
      end
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

  def calc_responded(id)
    participants = Project.find(id).participants
    count = 0
    total = 0
    participants.each do |participant|
      unless participant.last_responded.nil?
        count += 1
      end
      total += 1
    end
    @num_responded[id] = count
    @responded_fraction[id] = count.to_f / total
  end

end
