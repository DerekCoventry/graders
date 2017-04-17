#scraper to get courses and course information

require 'nokogiri'
require 'mechanize'
require 'open-uri'
require 'date'
require 'time'
require 'json'

#variable and arrays
LINK = 'http://www.physics.ohio-state.edu/~barrett/schedule/CSE/'
semName = ''
semYear = 0
switch = true

COURSENUMBER = Array.new
SECTIONNUMBER = Array.new
MONDAYSTART = Array.new
MONDAYEND = Array.new
TUESDAYSTART = Array.new
TUESDAYEND = Array.new
WEDNESDAYSTART = Array.new
WEDNESDAYEND = Array.new
THURSDAYSTART = Array.new
THURSDAYEND = Array.new
FRIDAYSTART = Array.new
FRIDAYEND = Array.new
PROFESSOR = Array.new


#necessary functions
def addDay(daysList, day)
	if(day == 'M') then
		daysList[0] = true
	end
	if(day == 'T') then
		daysList[1] = true
	end
	if(day == 'W') then
		daysList[2] = true
	end
	if(day == 'R') then
		daysList[3] = true
	end
	if(day == 'F') then
		daysList[4] = true
	end
end

def calculateEndTime(startingTime)
	t = startingTime + 55
	t = t.to_s
	if t[t.length-2].to_i > 6 then
		t[t.length-2] = (t[t.length-2].to_i - 6).to_s
		t[t.length-3] = (t[t.length-3].to_i + 1).to_s
	end 
	t = t.to_i
	return t
end

def addTime(daysList, startingTime, endTime, i)
	if (daysList[0]) then
		MONDAYSTART[i] = startingTime
		if endTime == 0 then
			endTime = calculateEndTime(startingTime)
		end
		MONDAYEND[i] = endTime
	end
	if (daysList[1]) then
		TUESDAYSTART[i] = startingTime
		if endTime == 0 then
			endTime = calculateEndTime(startingTime)
		end
		TUESDAYEND[i] = endTime
	end
	if (daysList[2]) then
		WEDNESDAYSTART[i] = startingTime
		if endTime == 0 then
			endTime = calculateEndTime(startingTime)
		end
		WEDNESDAYEND[i] = endTime
	end
	if (daysList[3]) then
		THURSDAYSTART[i] = startingTime
		if endTime == 0 then
			endTime = calculateEndTime(startingTime)
		end
		THURSDAYEND[i] = endTime
	end
	if (daysList[4]) then
		FRIDAYSTART[i] = startingTime
		if endTime == 0 then
			endTime = calculateEndTime(startingTime)
		end
		FRIDAYEND[i] = endTime
	end
end


#Get the page with the links
scraper = Mechanize.new
source = scraper.get('http://www.physics.ohio-state.edu/~barrett/schedule/CSE/?C=M;O=D')
homePage = Nokogiri::HTML(open(source.uri.to_s))

#get the rows with the appropriate links
trList = homePage.css("table tr")
trList.shift()
trList.shift()
trList.shift()
count = 0
trList.each do |s|
	if (s.text.match(Date.today.year.to_s) != nil || s.text.match((Date.today.year + 1).to_s)) then
		count += 1
	end
end
trList = trList.to_a
trLinks = trList.take(count)

# follow links to pages and get schedules
for a in 0..trLinks.length-1 do
	scraperInnerPage = Mechanize.new
	links = trLinks[a].to_s.split("\n") 											
	linkToFollow = ((links[2].partition(/\"\>/))[2].partition(/\</))[0].to_s
	linkSrc = LINK + linkToFollow
	linkSource = scraperInnerPage.get(linkSrc)
	linkPage = Nokogiri::HTML(open(linkSource.uri.to_s))
	textPart = (linkPage.css("p")).to_a
	info = textPart[0].to_s
	courses = info.partition(/LMA/)[0]
	semName = courses.slice(21, 2)
	semYear = courses.slice(28, 4)
	courses = courses.slice!(160, courses.length-1)
	courses.strip!
	courses = courses.reverse.slice(15, courses.length - 1).reverse
	courseList = courses.split("CSE")
	courseList.delete_if {|x| x.length == 0 }
	courseList.each do |x|
		x.strip!
	end
	file = File.open("#{semName} #{semYear} Course Schedule.json", "w")

	# loop to split page into lines per course offering
	for i in 0..courseList.length-1 do	
		text = courseList[i].to_s.split("   ")
		text.delete_if { |x| x.length == 0 }
		text.each do |x|
			x.strip!
		end

		# loop to parse each line and save required data to the arrays
		for j in 0..text.length - 1 do
			if switch then
				daysList = [false, false, false, false, false]
			end
			startingTime = 0
			endTime = 0

			if(j==0) then 
				COURSENUMBER[i] = (text[j]) 
			elsif(j==1) then 
				SECTIONNUMBER[i] = (text[j].split()[0]) 
			elsif(text[j].index(/[0-9]*(A|P)/) != nil) then  
				if text[j].length == 5 then
					if (text[j])[4] == "P" then
						startingTime = text[j].slice(0,4).to_i + 1200
					else
						startingTime = text[j].slice(0,4).to_i
					end
					addTime(daysList, startingTime, endTime, i)
					switch = true
				elsif text[j].length == 10 then
					times = text[j].split("-")
					if (times[0])[4] == "P" then
						startingTime = times[0].slice(0,4).to_i + 1200
						endTime = times[1].to_i + 1200
					else
						startingTime = times[0].slice(0,4).to_i
						endTime = times[1].to_i
					end
					addTime(daysList, startingTime, endTime, i)
					switch = true
				end
			elsif(text[j].index(/\//) != nil) then 
				next; 
			elsif(text[j].index(/[A-Z][A-Z][0-9]/) != nil) then 
				next; 
			elsif(text[j].index(/\(/) != nil) then 
				next;
			elsif(text[j].index(/\{/) != nil) then 
				next;
			elsif(text[j].index(/and  /) != nil) then 
				day = (text[j].split("  ")[1])
				addDay(daysList, day)
				switch = false
			elsif(text[j].index(/[A-Z]\./) != nil) then 
				PROFESSOR[i] = text[j]
			elsif(text[j].index(/[A-Z][A-Z]/) != nil) then 
				addDay(daysList, (text[j])[0])
				addDay(daysList, (text[j])[1])
				switch = false
			elsif(text[j].index(/[A-Z] [A-Z]/) != nil) then 
				addDay(daysList, (text[j])[0])
				addDay(daysList, (text[j])[2])
				switch = false
			elsif(text[j].index(/[A-Z]/) != nil) then 
				addDay(daysList, (text[j])[0])
				switch = false
			end
		end	
	end
	h = Course.new
	h.courseNumber  = COURSENUMBER
	h.mondayStart = MONDAYSTART
	h.mondayEnd = MONDAYEND
	h.tuesdayStart = TUESDAYSTART
	h.tuesdayEnd = TUESDAYEND
	h.wednesdayStart = WEDNESDAYSTART
	h.wednesdayEnd = WEDNESDAYEND
	h.thursdayStart = THURSDAYSTART
	h.thursdayEnd = THURSDAYEND
	h.fridayStart = FRIDAYSTART
	h.fridayEnd = FRIDAYEND
	h.professor = PROFESSOR
	h.sectionNumber = SECTIONNUMBER
	h.save
	#file.puts (JSON.fast_generate(h))  #use pretty_generate for processed output, fast_generate to get json in one line
	file.close
end
