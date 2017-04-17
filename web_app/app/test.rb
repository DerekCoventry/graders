require 'json'
load 'scrape_courses.rb'

file = File.open("Su 2017 Course Schedule.json", "r")
lines = IO.readlines(file) 
file.close
a_hash = JSON.parse(lines[0].to_s)
iter = 0
a_hash.each do |x|
	if x[1].length > iter then
		iter = x[1].length
	end
end
a_arr = a_hash.to_a
for i in 0..iter - 1 do
	new_record = Course.create!(courseNumber: ((a_arr[0])[1])[i],
								mondayStart: ((a_arr[1])[1])[i],
								mondayEnd: ((a_arr[2])[1])[i],
								tuesdayStart: ((a_arr[3])[1])[i],
								tuesdayEnd: ((a_arr[4])[1])[i],
								wednesdayStart: ((a_arr[5])[1])[i],
								wednesdayEnd: ((a_arr[6])[1])[i],
								thursdayStart: ((a_arr[7])[1])[i],
								thursdayEnd: ((a_arr[8])[1])[i],
								fridayStart: ((a_arr[9])[1])[i],
								fridayEnd: ((a_arr[10])[1])[i],
								professor: ((a_arr[11])[1])[i],
								sectionNumber: ((a_arr[12])[1])[i],
								)
end
