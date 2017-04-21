class PrereqsController < ApplicationController
  require 'open-uri'
  before_action :set_prereq, only: [:show, :edit, :update, :destroy]

  # GET /prereqs
  # GET /prereqs.json
  def index
    @prereqs = Prereq.all
  end

  # GET /prereqs/1
  # GET /prereqs/1.json
  def show
  end

  # GET /prereqs/new
  def new
    @prereq = Prereq.new
  end

  # GET /prereqs/1/edit
  def edit
  end



  # POST /prereqs
  # POST /prereqs.json
  def create
    @prereq = Prereq.new(prereq_params)

    respond_to do |format|
      if @prereq.save
        format.html { redirect_to @prereq, notice: 'Prereq was successfully created.' }
        format.json { render :show, status: :created, location: @prereq }
      else
        format.html { render :new }
        format.json { render json: @prereq.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prereqs/1
  # PATCH/PUT /prereqs/1.json
  def update
    respond_to do |format|
      if @prereq.update(prereq_params)
        format.html { redirect_to @prereq, notice: 'Prereq was successfully updated.' }
        format.json { render :show, status: :ok, location: @prereq }
      else
        format.html { render :edit }
        format.json { render json: @prereq.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prereqs/1
  # DELETE /prereqs/1.json
  def destroy
    @prereq.destroy
    respond_to do |format|
      format.html { redirect_to prereqs_url, notice: 'Prereq was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def gatherdata
  end

  def gather
    @courses = Prereq.all
    classnum = [1110, 1111, 1222, 1223, 2111, 2122, 2123, 2221, 2231, 2321, 2331, 2421, 2431, 2501, 
    3241, 3321, 3461, 3521, 3901, 3902, 4191, 4251, 4252, 4471, 5022, 5023, 5032, 5042, 
    5241, 5321, 5331, 5431, 5434, 5461, 5501, 5521, 5911, 6239, 6429, 2112, 2133, 2451, 
    3231, 3232, 3341, 3421, 3430, 3541, 3903, 4253, 5043, 5194, 5231, 5232, 5234, 5236, 
    5242, 5243, 5249, 5341, 5421, 5429, 5433, 5441, 5449, 5469, 5472, 5479, 5522, 5523, 
    5524, 5526, 5539, 5541, 5542, 5559, 5891, 5912, 5914, 5915, 6249, 6331, 6341, 6421, 
    6431, 6449, 6461, 6469, 6539, 6559]

    prev = [[1110, 1113, 1111, 1112], 
    [1111, 1113, 1112], 
    [1222], 
    [1223], 
    [2111], 
    [2122, 1222], 
    [2123, 1223], 
    [2221, 1212, 1211, 1223, 1222, 1221], 
    [2231, 2321, 2221, 1223, 1222, 1221, 1211, 2122, 2123, 1212], 
    [2321, 2122, 2123, 2221, 1223, 1222, 1221, 1211, 1212], 
    [2331, 2231, 2321, 2221, 1223, 1222, 1221, 1211, 2122, 2123, 1212], 
    [2421, 1232], 
    [2431], 
    [2501, 1222, 2421, 2321, 2231, 2122, 2123, 2221, 1223, 1221, 1211, 1232, 1212], 
    [3241, 2231, 5241, 2321, 2122, 2123, 2221, 1223, 1222, 1221, 1211, 1212], 
    [3321, 2231, 5321, 2221, 1223, 1222, 1221, 1211, 2321, 2122, 2123, 1212], 
    [3461, 2421, 1232], 
    [3521, 2331, 2231, 2321, 2221, 1223, 1222, 1221, 1211, 2122, 2123, 1212], 
    [3901, 2231, 2451, 2321, 2122, 2123, 2221, 1223, 1222, 1221, 1211, 1212], 
    [3902, 2231, 2451, 2321, 2122, 2123, 2221, 1223, 1222, 1221, 1211, 1212], 
    [4191], 
    [4251, 2231, 2321, 2221, 1223, 1222, 1221, 1211, 2122, 2123, 1212], 
    [4252], 
    [4471], 
    [5022], 
    [5023], 
    [5032], 
    [5042], 
    [5241, 2231, 3241, 2321, 2122, 2123, 2221, 1223, 1222, 1221, 1211, 1212], 
    [5321, 2231, 3321, 2221, 1223, 1222, 1221, 1211, 2321, 2122, 2123, 1212], 
    [5331, 2231, 2321, 2221, 1223, 1222, 1221, 1211, 2122, 2123, 1212], 
    [5431], 
    [5434, 5431, 2431], 
    [5461, 2560], 
    [5501, 1222, 2421, 2321, 2231, 2122, 2123, 2221, 1223, 1221, 1211, 1232, 1212], 
    [5521, 2331, 2231, 2321, 2221, 1223, 1222, 1221, 1211, 2122, 2123, 1212], 
    [5911, 2501, 5231, 3231, 4902, 4901, 3901, 5501, 2451, 2321, 2231, 2421, 2122, 2123, 2221, 1223, 1222, 1221, 1211, 1232, 1212, 3902], 
    [6239], 
    [6429], 
    [2112], 
    [2133], 
    [2451, 2221, 1212, 1211, 1223, 1222, 1221], 
    [3231, 3902, 3901, 2231, 2451, 2321, 2122, 2123, 2221, 1223, 1222, 1221, 1211, 1212], 
    [3232, 3902, 3901, 2231, 2451, 2321, 2122, 2123, 2221, 1223, 1222, 1221, 1211, 1212], 
    [3341, 5341, 3902, 3901, 2231, 2451, 2321, 2122, 2123, 2221, 1223, 1222, 1221, 1211, 1212], 
    [3421, 2231, 2321, 2221, 1223, 1222, 1221, 1211, 2122, 2123, 1212], 
    [3430], 
    [3541, 3902, 3901, 2231, 2451, 2321, 2122, 2123, 2221, 1223, 1222, 1221, 1211, 1212], 
    [3903, 2231, 2451, 2321, 2122, 2123, 2221, 1223, 1222, 1221, 1211, 1212], 
    [4253], 
    [5043], 
    [5194], 
    [5231, 3902, 3901, 2231, 2451, 2321, 2122, 2123, 2221, 1223, 1222, 1221, 1211, 1212], 
    [5232, 3902, 3901, 2231, 2451, 2321, 2122, 2123, 2221, 1223, 1222, 1221, 1211, 1212], 
    [5234, 5431, 3431], 
    [5236, 3902, 3901, 2231, 2451, 2321, 2122, 2123, 2221, 1223, 1222, 1221, 1211, 1212], 
    [5242], 
    [5243, 3241, 2331, 2231, 5241, 2321, 2122, 2123, 2221, 1223, 1222, 1221, 1211, 1212], 
    [5249], 
    [5341, 3341, 3902, 3901, 2231, 2451, 2321, 2122, 2123, 2221, 1223, 1222, 1221, 1211, 1212], 
    [5421, 2231, 2321, 2221, 1223, 1222, 1221, 1211, 2122, 2123, 1212], 
    [5429], 
    [5433, 5431, 2431], 
    [5441, 2560], 
    [5449], 
    [5469], 
    [5472, 3901, 3902, 2451, 2321, 2231, 2122, 2123, 2221, 1223, 1222, 1221, 1211, 1212], 
    [5479], 
    [5522, 5521, 3521, 2331, 2231, 2321, 2221, 1223, 1222, 1221, 1211, 2122, 2123, 1212], 
    [5523, 5521, 3521, 2331, 2231, 2321, 2221, 1223, 1222, 1221, 1211, 2122, 2123, 1212], 
    [5524], 
    [5526], 
    [5539], 
    [5541, 3902, 3901, 2231, 2451, 2321, 2122, 2123, 2221, 1223, 1222, 1221, 1211, 1212], 
    [5542, 3901, 2231, 2451, 2321, 2122, 2123, 2221, 1223, 1222, 1221, 1211, 1212], 
    [5559], 
    [5891], 
    [5912, 2501, 5541, 3541, 4902, 4901, 3902, 3901, 5501, 2451, 2321, 2231, 2421, 2122, 2123, 2221, 1223, 1222, 1221, 1211, 1232, 1212], 
    [5914, 2501, 5521, 3521, 4902, 4901, 3902, 3901, 5501, 2451, 2321, 2231, 2421, 2122, 2123, 2221, 1223, 1222, 1221, 1211, 1232, 1212, 2331], 
    [5915, 2501, 5241, 3241, 4902, 4901, 3902, 3901, 5501, 2321, 2451, 2231, 2421, 2122, 2123, 2221, 1223, 1222, 1221, 1211, 1232, 1212], 
    [6249], 
    [6331, 5331, 2331, 2231, 2321, 2221, 1223, 1222, 1221, 1211, 2122, 2123, 1212], 
    [6341, 5341, 3341, 3902, 3901, 2231, 2451, 2321, 2122, 2123, 2221, 1223, 1222, 1221, 1211, 1212], 
    [6421, 3421, 5431, 3431, 2231, 2321, 2221, 1223, 1222, 1221, 1211, 2122, 2123, 1212], 
    [6431, 5431, 2431], 
    [6449], 
    [6461], 
    [6469], 
    [6539], 
    [6559]]

    classes = Array.new
    classid = Hash.new


    for i in 0...classnum.length 
      classid[classnum[i].to_s] = i
      classes[i] = Array.new
      classes[i] << classnum[i]
      begin
        found = Array.new
        nex = 0
        io = open ('http://coe-portal.cse.ohio-state.edu/pdf-exports/CSE/CSE-'+classnum[i].to_s+'.pdf')

        reader = PDF::Reader.new(io)
        page = reader.page(1)
        x = page.text
        loc = x.index("Prerequisites and Co-requisites:")-9
        y = x[loc, 100]
        #puts y
        y.delete!("\n").delete!(' ')
        y.to_enum(:scan,"CSE").map do |m,|
          found << $'.size
        end
        if found.length > 0
          for indices in 0...found.length
            count = 0

            nex = found[indices]
            while y[nex+count] != 'E' && count < 9

              count += 1
            end
            if count < 9
              subs = y[nex+1+count, 4]
              if subs[/[0-9]+/] == subs
                #puts subs.to_i
                classes[i] << subs.to_i
              end
            end
          end
        end
      rescue => e 
        case e 
        when OpenURI::HTTPError
            else
              raise e
            end 
        end
      sleep(0.5)
    end
    total = 0
    #merge with previous
    for i in 0...classes.length
      total += prev[i].length
      classes[i] = classes[i] + prev[i]
    end
    total = 0
    #lets shuffle these arrays a few times
    for i in 0..3
      for x in 0...classes.length
        for y in 1...classes[x].length 
          if classnum.include? classes[x][y]
            classes[x] = classes[x] + classes[classid[(classes[x][y]).to_s]]
          end
        end
        classes[x] = classes[x].uniq
        total += classes[x].length
      end
      total = 0
    end
    for i in 0...classes.length
      if @courses.exists? classes[i][0]
        @current_found = @courses.find classes[i][0]
      else
        @current_found = Prereq.new
        @current_found.courseNumber = classes[i][0]
      end
      @current_found.req = classes[i]
      post_array = Array.new
      post_array << @current_found.courseNumber
      for postcount in 0...classes.length
        if classes[postcount].include? @current_found.courseNumber
          post_array << classes[postcount][0]
        end
      end
      @current_found.post = post_array.uniq
      @current_found.save
    end
    redirect_to prereqs_url
  end
  helper_method :gather
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prereq
      @prereq = Prereq.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prereq_params
      params.require(:prereq).permit(:courseNumber, :req)
    end
end

