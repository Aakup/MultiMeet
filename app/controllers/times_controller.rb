class TimesController < ApplicationController
  
  # GET /times/new
  def new
    @time = ProjectTime.new
    @project_id = params[:project_id]
    @duration = Project.find(@project_id).duration
    if !@duration.nil?
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

    @project_id = params[:project_id]
    @project = Project.find(@project_id)
    @times = @project.project_times.order(:date_time)
    @duration = @project.duration
  end

  def update_duration_from_params
    hour = params[:timeslot_hour].to_i
    minute = params[:timeslot_minute].to_i
    @duration = hour * 60 + minute
    @project.update(duration: @duration)
  end

  def add_date_to_db(date)
    if @project.project_times.where(date_time: DateTime.parse(date), is_date: true).blank?
      @time = @project.project_times.new(date_time: date, is_date: true)
      if @time.save
        (flash[:message] ||= "") << "Date: #{date}. "
      end
    else
       (flash[:error] ||= "") << "Date: #{date}. "
    end
  end

  def add_time_to_db(date, time)
    time = time + ":00"
    if @project.project_times.where(date_time: DateTime.parse(date + " " + time), is_date:false).blank?
      @time = @project.project_times.new(date_time: DateTime.parse(date + " " + time), is_date:false)
      if @time.save
        (flash[:message] ||= "") << "Time: #{date + " " + time}. "
      end
    else
       (flash[:error] ||= "") << "Time: #{date + " " + time}. "
    end

  end

  # POST /times/new
  # POST /times.json
  def create
    @project_id = params[:project_id]
    @project = Project.find(@project_id)
    @form_times = params[:times]

    if params[:project_time][:date_time].nil? or params[:project_time][:date_time].empty?
      flash[:message] = "No date chosen."
      redirect_to new_project_time_path and return
    end
    
    update_duration_from_params

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

    redirect_to project_times_path
  end
  
  def destroy_all
    @project_id = params[:project_id]
    @project = Project.find(@project_id)
    @project.project_times.destroy_all
    @project.update(duration: nil)
    redirect_to project_times_path
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