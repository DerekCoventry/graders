class Course < ApplicationRecord
	def self.filter_course_num(course)
	    where('courseNumber == ?', course)
	end
	def self.filter_course_sect(section)
	    where('sectionNumber == ?', section)
	end
end
