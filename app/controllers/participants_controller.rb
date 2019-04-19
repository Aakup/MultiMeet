class ParticipantsController < ApplicationController
  before_action :set_participant, only: [:show, :edit, :update, :destroy]
  before_action :set_new_user, only: [:display]

  # GET /participants
  # GET /participants.json
  def index
    if !logged_in?
      require_user
      return
    end

    @participants = Participant.all
  end

  # GET /participants/1
  def display
    @participants = Participant.where(project_id: params[:project_id])
  end

  # GET /participants/1
  # GET /participants/1.json
  # def show
  #   redirect_to projects_path
  # end

  # GET /participants/new
  # def new
  #   @participant = Participant.new
  # end

  # POST /participants
  # POST /participants.json
  def create
    @participant = Participant.new(participant_params)
    @participant.project_id = params[:project_id]
    if !Participant.where(
        project_id: @participant.project_id, email: @participant.email).blank?
      flash[:error] = "Participant's email already exists"
      redirect_to display_project_participants_path(params[:project_id])
    else @participant.save!
      flash[:success] = "Successfully created participant #{@participant.email}"
      redirect_to display_project_participants_path(params[:project_id])
    # else
    #   flash[:message] = @user.errors.full_messages
    #   redirect_to display_project_participants_path(params[:project_id])
    end
  end

  # PATCH/PUT /participants/1
  # PATCH/PUT /participants/1.json
  # def update
  #   respond_to do |format|
  #     if @participant.update(participant_params)
  #       @participant.project_id = participant_params[:project_id]
  #       @participant.email = participant_params[:email]
  #       format.html { redirect_to display_project_participants_path(params[:project_id]), notice: 'Participant was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @participant }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @participant.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /participants/1
  # DELETE /participants/1.json
  def destroy
    @participant.destroy
    redirect_to display_project_participants_path(@participant.project_id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participant
      @participant = Participant.find(params[:format])
    end

    def set_new_user
      @participant = Participant.new
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def participant_params
      params.require(:participant).permit(:email)
    end
end
