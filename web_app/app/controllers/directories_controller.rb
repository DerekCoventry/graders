class DirectoriesController < ApplicationController
  require "open-uri"
  before_action :set_directory, only: [:show, :edit, :update, :destroy]

  # GET /directories
  # GET /directories.json
  def index
    @directories = Directory.all
  end

  # GET /directories/1
  # GET /directories/1.json
  def show
  end

  # GET /directories/new
  def new
    @directory = Directory.new
  end

  # GET /directories/1/edit
  def edit
  end

  # POST /directories
  # POST /directories.json
  def create
    @directory = Directory.new(directory_params)

    respond_to do |format|
      if @directory.save
        format.html { redirect_to @directory, notice: 'Directory was successfully created.' }
        format.json { render :show, status: :created, location: @directory }
      else
        format.html { render :new }
        format.json { render json: @directory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /directories/1
  # PATCH/PUT /directories/1.json
  def update
    respond_to do |format|
      if @directory.update(directory_params)
        format.html { redirect_to @directory, notice: 'Directory was successfully updated.' }
        format.json { render :show, status: :ok, location: @directory }
      else
        format.html { render :edit }
        format.json { render json: @directory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /directories/1
  # DELETE /directories/1.json
  def destroy
    @directory.destroy
    respond_to do |format|
      format.html { redirect_to directories_url, notice: 'Directory was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def gatherdata
    gatherdirectory
    redirect_to directories_url
  end
  def gatherdirectory
    puts "enter"
    require "open-uri"



    agent = Mechanize.new
    staffpage = agent.get("https://cse.osu.edu/directory")
    @directory = Directory.all
    doc = Nokogiri::HTML(open(staffpage.uri.to_s))
    selects = doc.xpath("//span//a")
    for i in 0...selects.length
      current = selects[i].to_s
      charCount = 0
      while current[charCount+16] != '"'
        charCount += 1
      end
      charPeriod = 0
      charAt = 0
      while current[charPeriod+16] != '.'
        charPeriod += 1
      end
      while current[charAt+16+charPeriod] != '@'
        charAt += 1
      end
      if @directory.exists? current[16,charCount].to_s
        puts "exist"
        newProf = @directory.find current[16,charCount].to_s
        newProf.professor = true
        newProf.key = current[16,charPeriod]+current[16+charPeriod,charAt]
        newProf.save
      else
        newProf = Directory.new
        newProf.email = current[16,charCount].to_s
        newProf.professor = true
        newProf.staff = false
        newProf.key = current[16,charPeriod]+current[16+charPeriod,charAt]
        newProf.save
      end
        @directory = Directory.all
    end
    staffpage2 = agent.get("https://cse.osu.edu/about-us/staff")
    @directory = Directory.all
    doc2 = Nokogiri::HTML(open(staffpage2.uri.to_s))
    selects2 = doc2.xpath("//span//a")
    for i in 0...selects2.length
      current = selects[i].to_s
      charCount = 0
      while current[charCount+16] != '"'
        charCount += 1
      end
      charPeriod = 0
      charAt = 0
      while current[charPeriod+16] != '.'
        charPeriod += 1
      end
      while current[charAt+16+charPeriod] != '@'
        charAt += 1
      end
      if @directory.exists? current[16,charCount].to_s
        newProf = @directory.find current[16,charCount].to_s
        newProf.professor = true
        newProf.key = current[16,charPeriod]+current[16+charPeriod,charAt]
        newProf.save
      else
        newProf = Directory.new
        newProf.email = current[16,charCount].to_s
        newProf.professor = true
        newProf.staff = true
        newProf.key = current[16,charPeriod]+current[16+charPeriod,charAt]
        newProf.save
      end
        @directory = Directory.all
    end
    staffpage3 = agent.get("https://cse.osu.edu/about-us/faculty")
    doc3 = Nokogiri::HTML(open(staffpage3.uri.to_s))
    selects3 = doc3.xpath("//span//a")
    for i in 0...selects3.length
      current = selects[i].to_s
      charCount = 0
      while current[charCount+16] != '"'
        charCount += 1
      end
      charPeriod = 0
      charAt = 0
      while current[charPeriod+16] != '.'
        charPeriod += 1
      end
      while current[charAt+16+charPeriod] != '@'
        charAt += 1
      end
      if @directory.exists? current[16,charCount].to_s
        newStaff = @directory.find current[16,charCount].to_s
        newStaff.staff = true
        newProf.key = current[16,charPeriod]+current[16+charPeriod,charAt]
        newStaff.save
      else
        newStaff = Directory.new
        newStaff.email = current[16,charCount].to_s
        newStaff.professor = false
        newStaff.staff = true
        newProf.key = current[16,charPeriod]+current[16+charPeriod,charAt]
        newStaff.save
      end
        @directory = Directory.all
    end
  end
  helper_method :gatherdirectory
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_directory
      @directory = Directory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def directory_params
      params.require(:directory).permit(:email, :professor, :staff, :key)
    end
end
