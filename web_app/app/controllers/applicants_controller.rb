class ApplicantsController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper SmartListing::Helper
  before_action :set_applicant, only: [:show, :edit, :update, :destroy]

  # GET /applicants
  # GET /applicants.json
  def index
    @courses = Course.all
    @references = Recommendation.all
    @sections = [0] + @courses.all.map{|s| s.sectionNumber}
    @applicants = Applicant.all
    @applicants.each do |s| s.references = 0 
      end
    @filterselected = "0"
    @sectionselected = "0"
    applicants_scope = @applicants


    filt = params[:filter].to_i
    @filterselected = filt.to_s
    sect = params[:sect].to_i
    @sectionselected = sect.to_s
    if filt != 0
      @courses = @courses.filter_course_num(filt)
      @sections = [0] + @courses.all.map{|s| s.sectionNumber}
      if sect != 0
        course_searched = @courses.filter_course_sect(sect)
        applicants_scope = Applicant.filter_by_course(filt)
        applicants_scope = applicants_scope.filter_hours([
          course_searched.mondayStart, course_searched.mondayEnd, 
          course_searched.tuesdayStart, course_searched.tuesdayEnd, 
          course_searched.wednesdayStart, course_searched.wednesdayEnd, 
          course_searched.thursdayStart, course_searched.thursdayEnd, 
          course_searched.fridayStart, course_searched.fridayEnd])
      else
        applicants_scope = Applicant.filter_by_course(filt)
      end
    end
      #(:classOne == filt) || (:classTwo == filt) || (:classThree == filt))  if params[:filter]
    #applicants_scope = Applicant.all.like(params[:filter]) if params[:filter]
    @applicants = smart_listing_create :applicants, applicants_scope, partial: "applicants/listing"
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
