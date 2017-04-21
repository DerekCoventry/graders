class Prereq < ApplicationRecord
	self.primary_key = "courseNumber"
	serialize :req
	serialize :post
	def self.filter_course_num_prereq(course)
	    where('courseNumber == ?', course)
	end
end
