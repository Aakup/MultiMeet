class ProjectsController < ApplicationController
  def index
    @user = current_user
    print(@user)
    if @user
      print(@user)
      @projects = Project.where(username: @user.username)
    end
  end
end
