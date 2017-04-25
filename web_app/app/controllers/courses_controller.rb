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
      if current_user.staff
        @courses = smart_listing_create :courses, @courses, partial: "courses/staff"
      elsif current_user.professor
        @courses = smart_listing_create :courses, @courses, partial: "courses/listing"
      else
        @courses = smart_listing_create  :courses,  @courses, partial: "courses/safe" 
      end
          
    end
  end
  def addgrader
    @email = params[:email].to_s
    @coursenum = params[:course].to_i
    @section = params[:section].to_s
    @applicants = Applicant.filter_by_email(@email)
    if @applicants.size > 0
      x = 0
      @applicants.each do |c|
        x=c.id
      end
      @app = @applicants.find x
      @courses = Course.filter_course_num(@coursenum)
      if @courses.size > 0
        course_searched_list = @courses.filter_course_sect(@section.to_s)
        if course_searched_list.size >  0
          x=0
          course_searched_list.each do |c|
            x=c.id
          end
          @course_searched = course_searched_list.find x
          if @course_searched.graderOne && @course_searched.graderOne.length > 8 
            if @course_searched.graderTwo && @course_searched.graderTwo.length > 8
              if @course_searched.graderThree && @course_searched.graderThree.length > 8
                if @course_searched.graderFour && @course_searched.graderFour.length > 8
                  redirect_to courses_url, :error => 'No room for '
                else
                  @course_searched.graderFour = @email
                  @course_searched.requestFour = true
                end
              else
                @course_searched.graderThree = @email
                @course_searched.requestThree = true
              end
            else
              @course_searched.graderTwo = @email
              @course_searched.requestTwo = true
            end
          else
            @course_searched.graderOne = @email
            @course_searched.requestOne = true
          end

          @course_searched.save
          @app.available = "0"
          @app.save
        end
      end
    end

    
  end
  def removerequest
    @email = params[:email].to_s
    @coursenum = params[:course].to_i
    @section = params[:section].to_s
    @applicants = Applicant.filter_by_email(@email)
    @courses = Course.filter_course_num(@coursenum)
    if @courses.size > 0
      course_searched_list = @courses.filter_course_sect(@section.to_s)
      if course_searched_list.size >  0
        x=0
        course_searched_list.each do |c|
          x=c.id
        end
        if x != 0
          @course_searched = course_searched_list.find x
          if @course_searched.graderOne = @email
            @course_searched.graderOne = ""
          elsif @course_searched.graderTwo = @email
            @course_searched.graderTwo = ""
          elsif @course_searched.graderThree = @email
            @course_searched.graderThree = ""
          elsif @course_searched.graderFour = @email
            @course_searched.graderFour = ""
          else
          end
          @course_searched.requested = @course_searched.requested - 1
          if @course_searched.graders != @course_searched.requested
            @course_searched.active = true
          end
          @course_searched.save
        end
      end
    end

    
  end

  def confirmgrader
    @email = params[:email].to_s
    @coursenum = params[:course].to_i
    @section = params[:section].to_s
    @applicants = Applicant.filter_by_email(@email)
    @courses = Course.filter_course_num(@coursenum)
    if @courses.size > 0
      course_searched_list = @courses.filter_course_sect(@section.to_s)
      if course_searched_list.size >  0
        x=0
        course_searched_list.each do |c|
          x=c.id
        end
        @course_searched = course_searched_list.find x
        if @course_searched.graderOne = @email
          @course_searched.requestOne = false
        elsif @course_searched.graderTwo = @email
          @course_searched.requestTwo = false
        elsif @course_searched.graderThree = @email
          @course_searched.requestThree = false
        elsif @course_searched.graderFour = @email
          @course_searched.requestFour = false
        else
        end
        @course_searched.graders = @course_searched.graders + 1
        if @course_searched.graders = @course_searched.requested
          @course_searched.active = false
        end
        @course_searched.save
      end
    end
  end
  def requestgrader
    @coursenum = params[:course].to_i
    @section = params[:section].to_s
    @applicants = Applicant.filter_by_email(@email)
    @courses = Course.filter_course_num(@coursenum)
    if @courses.size > 0
      course_searched_list = @courses.filter_course_sect(@section.to_s)
      if course_searched_list.size >  0
        x=0
        course_searched_list.each do |c|
          x=c.id
        end
        @course_searched = course_searched_list.find x
        if @course_searched.requestOne = @email
          @course_searched.requestOne = true
        elsif @course_searched.requestTwo = @email
          @course_searched.requestTwo = true
        elsif @course_searched.requestThree = @email
          @course_searched.requestThree = true
        elsif @course_searched.requestFour = @email
          @course_searched.requestFour = true
        else

        end
        @course_searched.active = true
        @course_searched.requested = @course_searched.requested + 1
        @course_searched.save
      end
    end
  end
  def activate
    @coursenum = params[:course].to_i
    @section = params[:section].to_s
    @applicants = Applicant.filter_by_email(@email)
    @courses = Course.filter_course_num(@coursenum)
    if @courses.size > 0
      course_searched_list = @courses.filter_course_sect(@section.to_s)
      if course_searched_list.size >  0
        x=0
        course_searched_list.each do |c|
          x=c.id
        end
        @course_searched = course_searched_list.find x
        if @course_searched.active
          @course_searched.active = false
        else
          @course_searched.active = true
        end
        @course_searched.save
      end
    end
  end

  def autofill
    Course.all.each do |course|
      if course.active
        for grader in 0...course.requested+course.graders
          case grader 
          when 0
            if course.graderOne && course.graderOne.length > 8
              course.requestOne = false
              course.graders = 1
              course.save
            else
              @applicants = Applicant.filter_by_looking()
              @applicants = @applicants.filter_by_course(course.courseNumber)
              if @applicants.length > 0
                @applicants = @applicants.filter_hours([
                  course.mondayStart || 9999, course.mondayEnd || 0, 
                  course.tuesdayStart || 9999, course.tuesdayEnd || 0, 
                  course.wednesdayStart || 9999, course.wednesdayEnd || 0, 
                  course.thursdayStart || 9999, course.thursdayEnd || 0, 
                  course.fridayStart || 9999, course.fridayEnd || 0])
                if @applicants.length > 0
                  found = @applicants.first
                  found.available = false
                  found.save
                  course.graderOne = found.email
                  course.graders = 1
                  course.save

                end
              end
            end
          when 1
            if course.graderTwo && course.graderTwo.length > 8
              course.requestTwo = false
              course.graders = 2
              course.save
            else
              @applicants = Applicant.filter_by_looking()
              @applicants = @applicants.filter_by_course(course.courseNumber)
              if @applicants.length > 0
                @applicants = @applicants.filter_hours([
                  course.mondayStart || 9999, course.mondayEnd || 0, 
                  course.tuesdayStart || 9999, course.tuesdayEnd || 0, 
                  course.wednesdayStart || 9999, course.wednesdayEnd || 0, 
                  course.thursdayStart || 9999, course.thursdayEnd || 0, 
                  course.fridayStart || 9999, course.fridayEnd || 0])
                if @applicants.length > 0
                  found = @applicants.first
                  found.available = false
                  found.save
                  course.graderTwo = found.email
                  course.graders = 2
                  course.save
                end
              end
            end
          when 2
            if course.graderThree && course.graderThree.length > 8
              course.requestThree = false
              course.graders = 3
              course.save
            else
              @applicants = Applicant.filter_by_looking()
              @applicants = @applicants.filter_by_course(course.courseNumber)
              if @applicants.length > 0
                @applicants = @applicants.filter_hours([
                  course.mondayStart || 9999, course.mondayEnd || 0, 
                  course.tuesdayStart || 9999, course.tuesdayEnd || 0, 
                  course.wednesdayStart || 9999, course.wednesdayEnd || 0, 
                  course.thursdayStart || 9999, course.thursdayEnd || 0, 
                  course.fridayStart || 9999, course.fridayEnd || 0])
                if @applicants.length > 0
                  found = @applicants.first
                  found.available = false
                  found.save
                  course.graderThree = found.email
                  course.graders = 3
                  course.save
                end
              end
            end
          when 3
            if course.graderFour && course.graderFour.length > 8
              course.requestFour = false
              course.graders = 4
              course.save
            else
              @applicants = Applicant.filter_by_looking()
              @applicants = @applicants.filter_by_course(course.courseNumber)
              if @applicants.length > 0
                @applicants = @applicants.filter_hours([
                  course.mondayStart || 9999, course.mondayEnd || 0, 
                  course.tuesdayStart || 9999, course.tuesdayEnd || 0, 
                  course.wednesdayStart || 9999, course.wednesdayEnd || 0, 
                  course.thursdayStart || 9999, course.thursdayEnd || 0, 
                  course.fridayStart || 9999, course.fridayEnd || 0])
                if @applicants.length > 0
                  found = @applicants.first
                  found.available = false
                  found.save
                  course.graderFour = found.email
                  course.graders = 4
                  course.save
                end
              end
            end
          else
          end
        end
      end
    end
  end

  def configure 
    @courses = Course.all
    smart_listing_create(:courses, @courses, partial: "courses/configure")
  end
  def final
    @courses = Course.all 
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
        format.html { redirect_to :back, notice: 'Course was successfully updated.' }
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
      params.require(:course).permit(:sectionNumber, :courseNumber, :mondayStart,
       :mondayEnd, :tuesdayStart, :tuesdayEnd, :wednesdayStart, :wednesdayEnd,
        :thursdayStart, :thursdayEnd, :fridayStart, :fridayEnd, :professor,
        :requestOne, :requestTwo, :requestThree, :requestFour, :active,
        :requested, :graders)
    end
end
