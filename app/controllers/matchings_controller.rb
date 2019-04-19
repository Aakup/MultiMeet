class MatchingsController < ApplicationController
  before_action :set_matching_and_project, only: [:show, :edit, :update, :destroy]

  # GET /project/:project_id/matching
  def show
    if !logged_in?
      require_user
      return
    end

    @proj_exists = !(@project.nil?)
    if @proj_exists
      @permission = current_user.id == @project.user.id
    end
    if @proj_exists and @matching
      @is_matching = true
      @parsed_matching = JSON.parse(@matching.output_json)
    elsif @proj_exists
      @is_matching = false
      @eligible_to_match = all_submitted_preferences?
    end
  end

  # GET /projects/:project_id/matching/new
  # def new
  #   @matching = Matching.new
  # end

  # TODO: convert to a PUT/ UPDATE
  # GET /projects/:project_id/matching/edit
  def edit
    respond_to do |format|
      if all_submitted_preferences?
        #matching = Matching.where(project_id: @project.id).update_all(output_json: api)
        if @matching.update(output_json: api)
          flash[:success] = 'Successfully matched.'
          format.html { redirect_to project_matching_path }
        # else
        #   format.html { render :edit }
        end
      end
    end
  end

  # POST /projects/:project_id/matching
  def create
    @project = Project.find_by(:id => params[:project_id])
    @matching = Matching.new({project_id: @project.id})
    @matching.output_json = api

    respond_to do |format|
      if @matching.save!
        flash[:success] = 'Successfully matched.'
        format.html { redirect_to project_matching_path }
      # else
      #   format.html { render :new }
      end
    end
  end

  # DELETE /projects/:project_id/matching
  # def destroy
  #   @matching.destroy
  #   respond_to do |format|
  #     flash[:success] = 'Matching was successfully destroyed.'
  #     format.html { redirect_to matchings_url }
  #   end
  # end

  def category
    "person_to_time"
  end

  def global_settings
    {"minutes": @project.duration}
  end

  def people
    all_participants_emails = @project.participants.pluck(:email)

    people = []
    for email in all_participants_emails
      row = {"name": email, "match_degree": 1}
      people.push(row)
    end

    people
  end

  def timeslots
    all_project_times = ProjectTime.where(project_id: @project.id).pluck(:date_time)

    timeslots = []
    for timeslot in all_project_times
      timeslot_formatted = timeslot.strftime('%Y-%m-%d %H:%M')
      row = {"timestamp": timeslot_formatted, "tracks": 1}
      timeslots.push(row)
    end

    timeslots
  end

  def preferences
    preferences = []
    @project.rankings.each do |ranking|
      timeslot = ranking.project_time.date_time
      timeslot_formatted = timeslot.strftime('%Y-%m-%d %H:%M')
      person = ranking.participant.email
      row = {"person_name": person, "timeslot": timeslot_formatted, "rank": ranking.rank}
      preferences.push(row)
    end

    preferences
  end

  def all_submitted_preferences?
    all_participants_ids = @project.participants.pluck(:id)
    all_project_time_ids = @project.project_times.pluck(:id)

    all_participants_ids.each do |participant_id|
      all_project_time_ids.each do |project_time_id|
        unless Ranking.find_by(participant_id: participant_id, project_time_id: project_time_id)
          return false
        end
      end
    end
    true
  end

  def api
    require 'rest-client'

    input = {
      :category => category,
      :global_settings => global_settings,
      :people => people,
      :timeslots => timeslots,
      :preferences => preferences
    }
    # print(JSON.pretty_generate(input))

    output = RestClient.post('http://api.multi-meet.com:5000/multimatch', input.to_json,
                             {content_type: :json, accept: :json}).body
    return output
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_matching_and_project
      @matching = Matching.find_by(params.slice(:project_id))
      @project = Project.find_by(:id => params[:project_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def matching_params
      params.require(:project_id)
    end
end
