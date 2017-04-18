class ApplicantsController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper SmartListing::Helper
  before_action :set_applicant, only: [:show, :edit, :update, :destroy]

  # GET /applicants
  # GET /applicants.json
  def index
    if user_signed_in? 
      if current_user.professor 
        @courses = Course.all
        @course_num = [0] + Course.all.map{|c| c.courseNumber}
        @references = Recommendation.all
        @sections = [0] + @courses.all.map{|s| s.sectionNumber}
        @applicants = Applicant.filter_by_looking()
        @applicants.each do |s| 
          s.references = 0 
          s.save
          end
        @references.each do |r|
          x = r.semail.to_s
          @applicants.each do |a|
            if a.email.to_s == x
              a.references = a.references + 1
              a.save
            end
          end
        end
        @filterselected = "0"
        @sectionselected = "0"
        applicants_scope = @applicants


        filt = params[:filter].to_i
        @filterselected = filt.to_s
        sect = params[:sect].to_i
        @sectionselected = sect.to_s
        puts sect
        if params[:filter].to_i != 0
          @courses = @courses.filter_course_num(params[:filter].to_i)
          @sections = [0] + @courses.all.map{|s| s.sectionNumber}
          if params[:sect].to_i != 0

              course_searched = @courses.filter_course_sect(params[:sect].to_s)
            x=0
            course_searched.each do |c|
              x=c.id
            end
            course_searched = course_searched.find x
            puts params[:pref]
            if params[:pref] != "on"
              applicants_scope = @applicants.filter_by_course(params[:filter].to_i)
            else
              applicants_scope = @applicants.filter_by_course_loose(params[:filter].to_i)
            end
            applicants_scope = applicants_scope.filter_hours([
              course_searched.mondayStart || 9999, course_searched.mondayEnd || 0, 
              course_searched.tuesdayStart || 9999, course_searched.tuesdayEnd || 0, 
              course_searched.wednesdayStart || 9999, course_searched.wednesdayEnd || 0, 
              course_searched.thursdayStart || 9999, course_searched.thursdayEnd || 0, 
              course_searched.fridayStart || 9999, course_searched.fridayEnd || 0])
          else
            applicants_scope = @applicants.filter_by_course(params[:filter])
          end
        else
          @applicants = @applicants.filter_by_email(current_user.email)

        end
          #(:classOne == filt) || (:classTwo == filt) || (:classThree == filt))  if params[:filter]
        #applicants_scope = Applicant.all.like(params[:filter]) if params[:filter]
        @applicants = smart_listing_create :applicants, applicants_scope, partial: "applicants/listing"
      else
        @applicants_scope = @applicants.filter_by_email(current_user.email)
        @applicants = smart_listing_create  :applicants, @applicants_scope, partial: "applicants/self" 
      end
          
    end
  end

  # GET /applicants/1
  # GET /applicants/1.json
  def show
  end

  # GET /applicants/new
  def new
    @applicant = Applicant.new
  end

  # GET /applicants/1/edit
  def edit
  end

  # POST /applicants
  # POST /applicants.json
  def create
    @applicant = Applicant.new(applicant_params)

    respond_to do |format|
      if @applicant.save
        format.html { redirect_to @applicant, notice: 'Applicant was successfully created.' }
        format.json { render :show, status: :created, location: @applicant }
      else
        format.html { render :new }
        format.json { render json: @applicant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /applicants/1
  # PATCH/PUT /applicants/1.json
  def update
    respond_to do |format|
      if @applicant.update(applicant_params)
        format.html { redirect_to @applicant, notice: 'Applicant was successfully updated.' }
        format.json { render :show, status: :ok, location: @applicant }
      else
        format.html { render :edit }
        format.json { render json: @applicant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applicants/1
  # DELETE /applicants/1.json
  def destroy
    @applicant.destroy
    respond_to do |format|
      format.html { redirect_to applicants_url, notice: 'Applicant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_applicant
      @applicant = Applicant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def applicant_params
      params.require(:applicant).permit(:fname, :lname, :year, :email, :schedule_id, :available,
        :mondayStartFirst, :mondayEndFirst,
        :tuesdayStartFirst, :tuesdayEndFirst,
        :wednesdayStartFirst, :wednesdayEndFirst,
        :thursdayStartFirst, :thursdayEndFirst,
        :fridayStartFirst, :fridayEndFirst,
        :mondayStartSecond, :mondayEndSecond, 
        :tuesdayStartSecond, :tuesdayEndSecond, 
        :wednesdayStartSecond, :wednesdayEndSecond, 
        :thursdayStartSecond, :thursdayEndSecond, 
        :fridayStartSecond, :fridayEndSecond,
        :schedule, :classOne, :classTwo, :classThree)
    end
end
