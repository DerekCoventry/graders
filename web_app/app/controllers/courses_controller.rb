class CoursesController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper SmartListing::Helper

  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    if user_signed_in? 
      @courses = Course.all
      @course_num = [0] + Course.all.map{|c| c.courseNumber}
      @sections = [0] + @courses.all.map{|s| s.sectionNumber}
      @filterselected = "0"
      @sectionselected = "0"
      filt = params[:filter].to_i
      @filterselected = filt.to_s
      sect = params[:sect].to_i
      @sectionselected = sect.to_s
      puts sect
      puts params[:add]
      if params[:filter].to_i != 0
        puts params[:filter]
        @courses = @courses.filter_course_num(params[:filter].to_i)
        @sections = [0] + @courses.all.map{|s| s.sectionNumber}
        if sect.to_i != 0
          @courses = @courses.filter_course_sect(params[:sect].to_s)
        end
      end

      courses_searched = @courses
      if current_user.professor 
        @courses = smart_listing_create :courses, @courses, partial: "courses/listing"
        puts "ye"
      else
        @courses = smart_listing_create  :courses,  @courses, partial: "courses/safe" 
      end
          
    end
  end
  def addgrader
    @email = params[:email].to_s
    @coursenum = params[:course].to_i
    @section = params[:section].to_s
    puts @section
    @applicants = Applicant.filter_by_email(@email)
    x = 0
    @applicants.each do |c|
      x=c.id
    end
    puts x
    @app = @applicants.find x
    @courses = Course.filter_course_num(@coursenum)
    course_searched_list = @courses.filter_course_sect(@section.to_s)
    x=0
    course_searched_list.each do |c|
      x=c.id
    end
    @course_searched = course_searched_list.find x
    if @course_searched.graderOne
      if @course_searched.graderTwo
        if @course_searched.graderThree
          if @course_searched.graderFour
          else
            @course_searched.graderFour = @email
          end
        else
          @course_searched.graderThree = @email
        end
      else
        @course_searched.graderTwo = @email
      end
    else
      @course_searched.graderOne = @email
    end
    @course_searched.save
    @app.available = "0"
    @app.save

    
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:sectionNumber, :courseNumber, :mondayStart, :mondayEnd, :tuesdayStart, :tuesdayEnd, :wednesdayStart, :wednesdayEnd, :thursdayStart, :thursdayEnd, :fridayStart, :fridayEnd, :professor)
    end
end
