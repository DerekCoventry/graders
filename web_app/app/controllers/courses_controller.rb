class CoursesController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper SmartListing::Helper

  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
      Course.all.each do |c| 
        if c.requested == nil
          c.requested = 0
        end
        if c.graders == nil
          c.graders = 0
        end
        if c.active == nil
          c.active = false
        end
        if c.graderOne.to_s.length < 8
          c.graderOne = nil
        end
        if c.graderTwo.to_s.length < 8
          c.graderTwo = nil
        end
        if c.graderThree.to_s.length < 8
          c.graderThree = nil
        end
        if c.graderFour.to_s.length < 8
          c.graderFour = nil
        end
        c.save
      end
      @courses = Course.all
      Course
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
      if user_signed_in? && current_user.staff
        @courses = smart_listing_create :courses, @courses, partial: "courses/staff"
      elsif user_signed_in? && current_user.professor
        @courses = smart_listing_create :courses, @courses, partial: "courses/listing"
      else
        @courses = smart_listing_create  :courses,  @courses, partial: "courses/safe" 
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
    @time_options = [0, 30, 100, 130, 200, 230, 300, 330, 400, 430, 500, 530, 600, 630, 700, 730, 800, 830, 900, 930, 1000, 1030, 1100, 1130, 1200, 1230, 1300, 1330, 1400, 1430, 1500, 1530, 1600, 1630, 1700, 1830, 1900, 1930, 2000, 2030, 2100, 2130, 2200, 2230, 2300, 2330, 2400]
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
  def gatherdata
  end

  def gathercourses

    rmkey = ["Room", "Session", "Topic"]

    agent = Mechanize.new
    body = agent.get("https://web.cse.ohio-state.edu/cgi-bin/portal/report_manager/display_schedule-drupal.cgi")
    page = Nokogiri::HTML(open(body.uri.to_s))
    menu = page.css("option").to_a

    count = 1
    term = Hash.new
    menu.each do |options|
      if (options.values[0] == "selected") then 
        if (count < 2) then
          term[options.text] = options.values[1]
          count += 1
        else
          break
        end
      else
        term[options.text] = options.values[0]
      end
    end

    termChoice = term["Spring 17"]

    system("curl 'https://web.cse.ohio-state.edu/cgi-bin/portal/report_manager/display_schedule-drupal.cgi?display_options=1;options=2regular;tc=#{termChoice}' -X POST -H 'Cookie: s_lv=1427572505425; AMCV_774C31DD5342CAF40A490D44%40AdobeOrg=793872103%7CMCIDTS%7C17115%7CMCMID%7C41310242508017284221911243189543611998%7CMCAAMLH-1479339330%7C7%7CMCAAMB-1479339330%7CNRX38WO0n5BH8Th-nqAG_A%7CMCAID%7CNONE; mp_fe42a3507c097e9a9d1e9f881d833cfb_mixpanel=%7B%22distinct_id%22%3A%20%2215412d2e6fe200-0011579bee1843-2a4c7d64-100200-15412d2e6ff1ca%22%2C%22%24initial_referrer%22%3A%20%22http%3A%2F%2Fosu.worldcat.org.proxy.lib.ohio-state.edu%2Ftitle%2Fratings-analysis-audience-measurement-and-analytics%2Foclc%2F862746433%26referer%3Dbrief_results%22%2C%22%24initial_referring_domain%22%3A%20%22osu.worldcat.org.proxy.lib.ohio-state.edu%22%7D; s_nr=1491277474858; optimizelyEndUserId=oeu1491287285981r0.051170592004489146; _4c_=dVPdTuM8EH0VZIncUFI7dn5aKUIVFFSpgoqW3UuU2NM0%2BtI4OE6hQn13xmnLLtK3ufDYZ45PxvPzSd43UJMxEyMWJLEIKWfRgPwH%2B5aMP4kplTM7MiYJpbGM8jxKREaDRECsRIgrJCBymmVkQD56nRENOU3CRMSHAZHN6f4nudcGWgCUOu8G5KUF82B0hywiddUJwXmA%2BMJo1Uk7w7%2BTydPjFKHOVHjYWNuMh8NC%2B0VWQeGu%2BlJv%2Fcboj71flbmvN6W%2Bbm1mwQfVDZt2aMCaEnbgK31js3x2l64oDTyMoavsvGztat9A%2BjxdvsxXr%2FPZcuW1kBm5ee4Jbe9dlnVRwSrLT74enKhdVktQyx7CV2092RkDtV3otrSlrlPmKS1nKn2YzKeX8e2EhxFmjcaJw48ixpayAq%2FVxmIQ8%2BmvyePt1JO6tii0hGKLJvXwgQp1XDL%2B%2BOz%2F6B7jQ%2Boz87pzeh%2BzLaTfCfbKerFMrelcCVTZSr0Ds1%2BC2ZUSZneYZsQtmC32AHEaFwXUYDCl6uL0byTkRr%2BjDylPDTovBEdQuyu%2Fy1qhD48G1oAJcaRT5XTb%2Be%2FaVEpm1tem%2BHfljg%2B5eUtdBFffEVydIvDebHosYfvaZAV4Kq%2BwlikTEbsMbllMEzR8REf9KeBHE6IJuMMijsmSGktAPV2p83b9lmLgWD7XqT%2BaDGGplYPZyOd%2BcL3zXa%2BuXfNi38tIMiFEzmMehZBQxuOIUpGvs0yEyGvcFAncVFqiLB5w8HBE%2FpqaEU2CBCFVqrku7hfn2WM%2FhwtpnCGtwYnoCezsZsHIrQnnWECLboyIus%2Bx%2BynERfwUY0nID4fDFw%3D%3D; cX_P=j14am5vcwkbob9nj; AMCV_4D6368F454EC41940A4C98A6%40AdobeOrg=2096510701%7CMCIDTS%7C17268%7CMCMID%7C41299256959947171721910142721363535372%7CMCAAMLH-1491892087%7C7%7CMCAAMB-1492490165%7CNRX38WO0n5BH8Th-nqAG_A%7CMCOPTOUT-1491892565s%7CNONE%7CMCAID%7CNONE%7CMCSYNCSOP%7C411-17275%7CvVersion%7C2.0.0; optimizelySegments=%7B%22204658328%22%3A%22false%22%2C%22204728159%22%3A%22none%22%2C%22204736122%22%3A%22referral%22%2C%22204775011%22%3A%22opera%22%7D; optimizelyBuckets=%7B%7D; s_pers=%20s_fid%3D71CEF445197A11CD-018F6E873C1DEC9C%7C1523677410381%3B%20v8%3D1491885591611%7C1586493591611%3B%20v8_s%3DLess%2520than%25207%2520days%7C1491887391611%3B%20c19%3Dsd%253Aproduct%253Ajournal%253Aarticle%7C1491887391618%3B%20v68%3D1491885591028%7C1491887391631%3B; s_vnum=1493868406516%26vn%3D10; _ga=GA1.2.1019892310.1454400803; __utma=259690636.1019892310.1454400803.1492622169.1492642724.75; __utmz=259690636.1484278826.2.2.utmcsr=google|utmccn=(organic)|utmcmd=organic|utmctr=(not%20provided)' -H 'Origin: https://web.cse.ohio-state.edu' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.8' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36 OPR/43.0.2442.1144' -H 'Content-Type: multipart/form-data; boundary=----WebKitFormBoundaryX1w8U2oovZCnYUBP' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Cache-Control: max-age=0' -H 'Referer: https://web.cse.ohio-state.edu/cgi-bin/portal/report_manager/display_schedule-drupal.cgi?display_options=1;options=2regular;tc=#{termChoice}' -H 'Connection: keep-alive' --data-binary $'------WebKitFormBoundaryX1w8U2oovZCnYUBP\r\nContent-Disposition: form-data; name=\"tc\"\r\n\r\n#{termChoice}\r\n------WebKitFormBoundaryX1w8U2oovZCnYUBP\r\nContent-Disposition: form-data; name=\"options\"\r\n\r\n2regular\r\n------WebKitFormBoundaryX1w8U2oovZCnYUBP\r\nContent-Disposition: form-data; name=\"Display Schedule\"\r\n\r\nDisplay Schedule\r\n------WebKitFormBoundaryX1w8U2oovZCnYUBP--\r\n' --compressed > coursepage.html 2>error.temp")
    system("rm error.temp")

    file = File.open("coursepage.html", "r")
    lines = IO.readlines(file)
    file.close

    string = ""

    lines.each do |x|
      string += x.to_s
    end

    string = string.split("<body>")[1].to_s

    string = string.split("</body>")[0].to_s

    string = string.split("</a>")[1].to_s

    s = string.split("<table>")
    s.delete_at(0)

    s.each do |i|
      daysList = [false, false, false, false, false]
      onDay = [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]

      coursenum = i.slice!(/<th>.*[0-9]<\/th>/)
      coursenum = coursenum.slice!(8, 4)
      coursenum.chomp!

      temp = i.to_s
      json = Jsoner.parse(temp)
      courseHash = JSON.parse(json)[0]
      courseHash["Course Number"] = coursenum

      rmkey.each do |x|
        courseHash.delete(x)
      end

      secString = courseHash["Section"]
      secString.slice!(0,10)
      secString.reverse!.slice!(0,1).reverse!
      courseHash["Section"] = secString

      courseHash.keys.each do |x|
        courseHash[x].chomp!
      end

      if(courseHash["Instructor"] == "NO INSTRUCTOR") then
        courseHash.delete("Instructor")
        courseHash["Instructor"] = nil
      end

      if(!courseHash["Days & Times"].match("ARR")) then
        daysAndTimes = courseHash["Days & Times"]
        courseHash.delete("Days & Times")

        day = (daysAndTimes.split(" ")[0])
        for i in 0..day.length - 1 do 
          if (day[i,i+2] == "Mo") then
            daysList[0] = true
          elsif (day[i,i+2] == "Tu") then
            daysList[1] = true
          elsif (day[i,i+2] == "We") then
            daysList[2] = true
          elsif (day[i,i+2] == "Th") then
            daysList[3] = true
          elsif (day[i,i+2] == "Fr") then
            daysList[4] = true
          end
          i += 2      
        end
        
        time = (daysAndTimes.split(" ")[1])
        startTime = DateTime.parse(time.split("-")[0]).strftime("%H%M")
        endTime = DateTime.parse(time.split("-")[1]).strftime("%H%M")

        for i in 0..4 do
          if (daysList[i]) then
            onDay[i] = startTime
            onDay[i+1] = endTime
          end
        end

        courseHash["mondayStart"]= onDay[0]
        courseHash["mondayEnd"]= onDay[1]
        courseHash["tuesdayStart"]= onDay[2]
        courseHash["tuesdayEnd"]= onDay[3]
        courseHash["wednesdayStart"]= onDay[4]
        courseHash["wednesdayEnd"]= onDay[5]
        courseHash["thursdayStart"]= onDay[6]
        courseHash["thursdayEnd"]= onDay[7]
        courseHash["fridayStart"]= onDay[8]
        courseHash["fridayEnd"]= onDay[9]
        newCourse = Course.new
        @course_search = Course.all.filter_course_num(courseHash["Course Number"])
        @course_search = @course_search.filter_course_sect(courseHash["Section"])
        if @course_search.length > 0
          newCourse = @course_search.first
        end
        newCourse.sectionNumber = courseHash["Section"]
        newCourse.courseNumber = courseHash["Course Number"]
        newCourse.mondayStart = courseHash["mondayStart"]
        newCourse.mondayEnd = courseHash["mondayEnd"]
        newCourse.tuesdayStart = courseHash["tuesdayStart"]
        newCourse.tuesdayEnd = courseHash["tuesdayEnd"]
        newCourse.wednesdayStart = courseHash["wednesdayStart"]
        newCourse.wednesdayEnd = courseHash["wednesdayEnd"]
        newCourse.thursdayStart = courseHash["thursdayStart"]
        newCourse.thursdayEnd = courseHash["thursdayEnd"]
        newCourse.fridayStart = courseHash["fridayStart"]
        newCourse.fridayEnd = courseHash["fridayEnd"]
        newCourse.professor = courseHash["Instructor"]
        newCourse.active = true
        newCourse.requested = 0
        newCourse.save
      end
    end
    @course = Course.all
  end
  helper_method :gathercourses

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
