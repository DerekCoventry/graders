class Applicant < ApplicationRecord
	has_many :schedule
	has_many :course
	paginates_per 50
	max_paginates_per 50
	def self.filter_by_email(emailCheck)
		where('email == ?', emailCheck)
	end
	def self.filter_by_looking()
		where('available == ?', true)
	end
	def self.filter_by_course(course)
	    where('classOne == ? OR classTwo == ? OR classThree == ?', course, course, course)
	end
	def self.filter_by_course_loose(course)
	    where('classOne >= ? OR classTwo >= ? OR classThree >= ?', course, course, course)
	end
	def self.filter_hours(params)
		where('((mondayStartFirst <= ? AND mondayEndFirst >= ?) OR (mondayStartSecond <= ? AND mondayEndSecond >= ?)) 
			AND ((tuesdayStartFirst <= ? AND tuesdayEndFirst >= ?) OR (tuesdayStartSecond <= ? AND tuesdayEndSecond >= ?))
			AND ((wednesdayStartFirst <= ? AND wednesdayEndFirst >= ?) OR (wednesdayStartSecond <= ? AND wednesdayEndSecond >= ?))
			AND ((thursdayStartFirst <= ? AND thursdayEndFirst >= ?) OR (thursdayStartSecond <= ? AND thursdayEndSecond >= ?))
			AND ((fridayStartFirst <= ? AND fridayEndFirst >= ?) OR (fridayStartSecond <= ? AND fridayEndSecond >= ?))', 
			params[0], params[1], params[0], params[1], params[2], params[3], params[2], params[3], params[4], params[5],
			params[4], params[5], params[6], params[7], params[6], params[7], params[8], params[9], params[8], params[9])
	end
end