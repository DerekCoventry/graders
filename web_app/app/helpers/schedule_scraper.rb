# scraper to get schedule information

require 'nokogiri'
require 'mechanize'
require 'open-uri'
require 'date'
require 'time'
require 'rest-client'
require 'rubygems'

# array holding all semester options 
semester = Array.new

# array holding schedule options
# schedules = Array.new

semesterVal = ''
# scheduleVal = '' 

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

# # extract possible schedule options and store in array
# doc.css('form select')[1].css('option').each do |opt|
# 	if opt.values.length > 1 then
# 		schedules.push(opt.values[1])
# 	else
# 		schedules.push(opt.values)
# 	end
# end
# scheduleVal = schedules[0]
# # puts schedules
# # puts "\n"

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
semesterOption = semesterVal[0].to_s

#Enter the appropriate info into form and click submit
form = source.forms.first
tcOption = Array.new

form.field_with(:name => "tc").options.each do |x|
	tcOption.push(x.to_s)
end
puts tcOption


REQUEST_URL = "https://web.cse.ohio-state.edu/cgi-bin/portal/report_manager/display_schedule-drupal.cgi?"

name_term = "Display Schedule"
value_term = "Display Schedule"

display_options = "------WebKitFormBoundaryTYBGAUoN8ERcWGOVContent-Disposition: form-data; name=\"tc\"1178------WebKitFormBoundaryTYBGAUoN8ERcWGOVContent-Disposition: form-data; name=\"options\"1full------WebKitFormBoundaryTYBGAUoN8ERcWGOVContent-Disposition: form-data; name=\"Display Schedule\"Display Schedule------WebKitFormBoundaryTYBGAUoN8ERcWGOV--"

headers = "POST /cgi-bin/portal/report_manager/display_schedule-drupal.cgi?display_options=1;options=1full;tc=1172 HTTP/1.1
Host: web.cse.ohio-state.edu
Connection: keep-alive
Content-Length: 355
Cache-Control: max-age=0
Origin: https://web.cse.ohio-state.edu
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36 OPR/43.0.2442.1144
Content-Type: multipart/form-data; boundary=----WebKitFormBoundaryTYBGAUoN8ERcWGOV
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
Referer: https://web.cse.ohio-state.edu/cgi-bin/portal/report_manager/display_schedule-drupal.cgi?display_options=1;options=1full;tc=1172
Accept-Encoding: gzip, deflate, br
Accept-Language: en-US,en;q=0.8
Cookie: s_lv=1427572505425; AMCV_774C31DD5342CAF40A490D44\%40AdobeOrg=793872103\%7CMCIDTS\%7C17115\%7CMCMID\%7C41310242508017284221911243189543611998\%7CMCAAMLH-1479339330\%7C7\%7CMCAAMB-1479339330\%7CNRX38WO0n5BH8Th-nqAG_A\%7CMCAID\%7CNONE; mp_fe42a3507c097e9a9d1e9f881d833cfb_mixpanel=\%7B\%22distinct_id\%22\%3A\%20\%2215412d2e6fe200-0011579bee1843-2a4c7d64-100200-15412d2e6ff1ca\%22\%2C\%22\%24initial_referrer\%22\%3A\%20\%22http\%3A\%2F\%2Fosu.worldcat.org.proxy.lib.ohio-state.edu\%2Ftitle\%2Fratings-analysis-audience-measurement-and-analytics\%2Foclc\%2F862746433\%26referer\%3Dbrief_results\%22\%2C\%22\%24initial_referring_domain\%22\%3A\%20\%22osu.worldcat.org.proxy.lib.ohio-state.edu\%22\%7D; s_nr=1491277474858; optimizelyEndUserId=oeu1491287285981r0.051170592004489146; _4c_=dVPdTuM8EH0VZIncUFI7dn5aKUIVFFSpgoqW3UuU2NM0\%2BtI4OE6hQn13xmnLLtK3ufDYZ45PxvPzSd43UJMxEyMWJLEIKWfRgPwH\%2B5aMP4kplTM7MiYJpbGM8jxKREaDRECsRIgrJCBymmVkQD56nRENOU3CRMSHAZHN6f4nudcGWgCUOu8G5KUF82B0hywiddUJwXmA\%2BMJo1Uk7w7\%2BTydPjFKHOVHjYWNuMh8NC\%2B0VWQeGu\%2BlJv\%2Fcboj71flbmvN6W\%2Bbm1mwQfVDZt2aMCaEnbgK31js3x2l64oDTyMoavsvGztat9A\%2BjxdvsxXr\%2FPZcuW1kBm5ee4Jbe9dlnVRwSrLT74enKhdVktQyx7CV2092RkDtV3otrSlrlPmKS1nKn2YzKeX8e2EhxFmjcaJw48ixpayAq\%2FVxmIQ8\%2BmvyePt1JO6tii0hGKLJvXwgQp1XDL\%2B\%2BOz\%2F6B7jQ\%2Boz87pzeh\%2BzLaTfCfbKerFMrelcCVTZSr0Ds1\%2BC2ZUSZneYZsQtmC32AHEaFwXUYDCl6uL0byTkRr\%2BjDylPDTovBEdQuyu\%2Fy1qhD48G1oAJcaRT5XTb\%2Be\%2FaVEpm1tem\%2BHfljg\%2B5eUtdBFffEVydIvDebHosYfvaZAV4Kq\%2BwlikTEbsMbllMEzR8REf9KeBHE6IJuMMijsmSGktAPV2p83b9lmLgWD7XqT\%2BaDGGplYPZyOd\%2BcL3zXa\%2BuXfNi38tIMiFEzmMehZBQxuOIUpGvs0yEyGvcFAncVFqiLB5w8HBE\%2FpqaEU2CBCFVqrku7hfn2WM\%2FhwtpnCGtwYnoCezsZsHIrQnnWECLboyIus\%2Bx\%2BynERfwUY0nID4fDFw\%3D\%3D; cX_P=j14am5vcwkbob9nj; AMCV_4D6368F454EC41940A4C98A6\%40AdobeOrg=2096510701\%7CMCIDTS\%7C17268\%7CMCMID\%7C41299256959947171721910142721363535372\%7CMCAAMLH-1491892087\%7C7\%7CMCAAMB-1492490165\%7CNRX38WO0n5BH8Th-nqAG_A\%7CMCOPTOUT-1491892565s\%7CNONE\%7CMCAID\%7CNONE\%7CMCSYNCSOP\%7C411-17275\%7CvVersion\%7C2.0.0; optimizelySegments=%7B\%22204658328\%22\%3A\%22false\%22\%2C\%22204728159\%22\%3A\%22none\%22\%2C\%22204736122\%22\%3A\%22referral\%22\%2C\%22204775011\%22\%3A\%22opera\%22\%7D; optimizelyBuckets=%7B\%7D; s_pers=%20s_fid\%3D71CEF445197A11CD-018F6E873C1DEC9C\%7C1523677410381\%3B\%20v8\%3D1491885591611\%7C1586493591611\%3B\%20v8_s\%3DLess\%2520than\%25207\%2520days\%7C1491887391611\%3B\%20c19\%3Dsd\%253Aproduct\%253Ajournal\%253Aarticle\%7C1491887391618\%3B\%20v68\%3D1491885591028\%7C1491887391631\%3B; s_vnum=1493868406516\%26vn\%3D10; _ga=GA1.2.1019892310.1454400803; __utma=259690636.1019892310.1454400803.1492123645.1492125664.66; __utmc=259690636; __utmz=259690636.1484278826.2.2.utmcsr=google|utmccn=(organic)|utmcmd=organic|utmctr=(not\%20provided)"
if page = RestClient.post(REQUEST_URL, display_options, headers={})
	puts page
	#File.open("https://web.cse.ohio-state.edu/cgi-bin/portal/report_manager/display_schedule-drupal.cgi?display_options=1;options=1full;tc=#{tcOption[2]}")
	
	# npage = Nokogiri::HTML(open(page.to_s))
 #    puts npage
end  















# #new mechanize object to open schedule page
# scheduleScraper = Mechanize.new
# scheduleSourceArray = Array.new
# sourceString = "https://web.cse.ohio-state.edu/cgi-bin/portal/report_manager/display_schedule-drupal.cgi?display_options=1;options=1full;tc=1178"

# sourceString.slice!(sourceString.length - 4..sourceString.length)

# for i in 0..tcOption.length - 1 do
# 	temp = ''
# 	temp << sourceString
# 	temp.concat(tcOption[i])
# 	scheduleSourceArray.push(temp)
# end

# scheduleSourceArray.each do |s|
# 	if (s.index(semesterOption) != nil) then
# 		sourceString.clear.concat(s)
# 	end
# end

# scheduleSource = scheduleScraper.get(sourceString)
# doc = Nokogiri::HTML(open(scheduleSource.uri.to_s))
# form = scheduleSource.forms.first
# newPage = form.submit
# newDoc = Nokogiri::HTML(open(newPage.uri.to_s))

# puts newDoc



# puts form.to_s

# schedulePage = form.submit
# puts schedulePage.title

# form.field_with(:name => "tc").first.select
# form.field_with(:name => "options").first.select
# schedulePage = form.submit
# puts Nokogiri::HTML(open(schedulePage.uri.to_s))


# puts scheduleVal
# puts scheduleVal.class