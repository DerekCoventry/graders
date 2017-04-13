# scraper to get schedule information

require 'nokogiri'
require 'mechanize'
require 'open-uri'
require 'date'
require 'time'

# hash holding all semester options (value:name)
semester = Array.new

# array holding schedule options
schedules = Array.new

semesterVal = ''
scheduleVal = '' 

# initialize mechanize object, and Nokogiri document
scraper = Mechanize.new
source = scraper.get('https://web.cse.ohio-state.edu/cgi-bin/portal/report_manager/display_schedule-drupal.cgi')
doc = Nokogiri::HTML(open(source.uri.to_s))

# extract possible semester options and store in array
doc.css('form select')[0].css('option').each do |opt|
	if opt.values.length > 1 then
		semester.push([opt.values[1], opt.text.to_s])
	else
		semester.push([opt.values, opt.text.to_s])
	end
end
# puts semester
# puts "\n"

# extract possible schedule options and store in array
doc.css('form select')[1].css('option').each do |opt|
	if opt.values.length > 1 then
		schedules.push(opt.values[1])
	else
		schedules.push(opt.values)
	end
end
scheduleVal = schedules[0]
# puts schedules
# puts "\n"

# check current month to determine the next semester and
# store the value corresponding to that semester
if (Date::MONTHNAMES[Date.today.month] < Date::MONTHNAMES[5]) then
	semester.each do |name|
		if name.include?(('Summer ' + Time.now.strftime("%y")))
			semesterVal = name.first
		end
	end
elsif (Date::MONTHNAMES[Date.today.month] > Date::MONTHNAMES[5] && 
	   Date::MONTHNAMES[Date.today.month] < Date::MONTHNAMES[8])
	semester.each do |name|
		if name.include?(('Autumn ' + Time.now.strftime("%y")))
			semesterVal = name.first
		end
	end
elsif (Date::MONTHNAMES[Date.today.month] > Date::MONTHNAMES[8])
	semester.each do |name|
		if name.include?(('Spring ' + (Time.now.strftime("%y").to_i + 1).to_s))
			semesterVal = name.first
		end
	end
end

#Enter the appropriate info into form and click submit
form = source.forms.first
semesterOption = semesterVal[0].to_s
scheduleVal = scheduleVal.to_i
tcOption = Array.new

form.field_with(:name => "tc").options.each do |x|
	tcOption.push(x.to_s)
end

#new mechanize object to open schedule page
scheduleScraper = Mechanize.new
scheduleSourceArray = Array.new
sourceString = "https://web.cse.ohio-state.edu/cgi-bin/portal/report_manager/display_schedule-drupal.cgi?display_options=1;options=1full;tc=1178"

sourceString.slice!(sourceString.length - 4..sourceString.length)

for i in 0..tcOption.length - 1 do
	temp = ''
	temp << sourceString
	temp.concat(tcOption[i])
	scheduleSourceArray.push(temp)
end

scheduleSourceArray.each do |s|
	if (s.index(semesterOption) != nil) then
		sourceString.clear.concat(s)
	end
end

scheduleSource = scheduleScraper.get(sourceString)
doc = Nokogiri::HTML(open(scheduleSource.uri.to_s))
form = scheduleSource.forms.first
newPage = form.submit
newDoc = Nokogiri::HTML(open(newPage.uri.to_s))

puts newDoc



# puts form.to_s

# schedulePage = form.submit
# puts schedulePage.title

# form.field_with(:name => "tc").first.select
# form.field_with(:name => "options").first.select
# schedulePage = form.submit
# puts Nokogiri::HTML(open(schedulePage.uri.to_s))


# puts scheduleVal
# puts scheduleVal.class