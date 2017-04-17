require 'json'

file = File.open("Su 2017 Course Schedule.json", "r")
lines = IO.readlines(file) 
a_hash = JSON.parse(lines[0].to_s)
puts a_hash
file.close

# file = File.open("../helpers/Su 2017 Course Schedule.json", "r")
# lines = IO.readlines(file) 
# new_record = Model.new(JSON.parse(lines[0].to_s)) 
# new_record.save
# file.close
