class TimesController < ApplicationController
  before_action :set_project_and_project_id, only: [:index, :create, :destroy_all]
  
  # GET /times/new
  def new
    @time = ProjectTime.new
    @project_id = params[:project_id]
    @duration = Project.find(@project_id).duration
    unless @duration.nil?
      @hour = @duration/60.ceil
      @minute = @duration - (@hour*60)
    end
  end
  
  # GET /times
  # GET /times.json
  def index
    if !logged_in?
      require_user
      return
    end

    @duration = @project.duration
    @times = @project.project_times.order(:date_time)
  end

  def update_duration_from_params
    hour = params[:timeslot_hour].to_i
    minute = params[:timeslot_minute].to_i
    @duration = hour * 60 + minute
    @project.update(duration: @duration)
  end

  def no_project_date_time?(date_time, is_date)
    @project.project_times.where(date_time: DateTime.parse(date_time), is_date: is_date).blank?
  end

  # returns if a project time was created and saved
  def create_project_time_if_needed(date, time, is_date)
    unless is_date
      date = date + " " + time
    end
    if no_project_date_time? date, is_date
      @time = @project.project_times.new(date_time: date, is_date: is_date)
      return @time.save
    end
    false
  end

  def add_date_to_db(date)
    create_project_time_if_needed date, nil, true
  end

  def add_time_to_db(date, time)
    time = time + ":00"
    if create_project_time_if_needed date, time, false
      (flash[:message] ||= "") << "#{DateTime.parse(date + " " + time).strftime("%A, %B %d %Y, %I:%M %p")}. "
    end
  end

  def add_requested_times_to_db
    @form_times = params[:times]
    #Loop Through params[:times]
    @form_times.keys.each do |date|
      #Add dates to database
      add_date_to_db date
      #Add times of the date into database
      @form_times[date].each_with_index do |time, index|
        if index % 2 == 0
          add_time_to_db date, time
        end
      end
    end
  end

  # POST /times/new
  # POST /times.json
  def create
    if params[:project_time][:date_time].nil? or params[:project_time][:date_time].empty?
      flash[:message] = "No date chosen."
      redirect_to new_project_time_path and return
    end

    update_duration_from_params

    add_requested_times_to_db

    redirect_to project_times_path
  end
  
  def destroy_all
    @project.project_times.destroy_all
    @project.update(duration: nil)
    redirect_to project_times_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time
      @time = ProjectTime.find(params[:id])
    end

    def set_project_and_project_id
      @project_id = params[:project_id]
      @project = Project.find_by(:id => @project_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def time_params
      params.require(:project_time)
    end
end

# PATCH/PUT /times/1
  # PATCH/PUT /times/1.json
  #def update
    #respond_to do |format|
      #if @time.update(time_params)
        #format.html { redirect_to @time, notice: 'Time was successfully updated.' }
        #format.json { render :show, status: :ok, location: @time }
      #else
        #format.html { render :edit }
        #format.json { render json: @time.errors, status: :unprocessable_entity }
      #end
    #end
  #end

  # DELETE /times/1
  # DELETE /times/1.json
  #def destroy
    #@time.destroy
    #end
  #end