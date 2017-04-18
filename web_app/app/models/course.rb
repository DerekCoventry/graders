class Course < ApplicationRecord

	def self.filter_course_num(course)
	    where('courseNumber == ?', course)
	end
	def self.filter_course_sect(section)
	    where('sectionNumber == ?', section)
	end
	def self.add_grader(email)
		if self.graderOne
			if self.graderTwo
				if self.graderThree
					if self.graderFour
					else
						self.graderFour = email
					end
				else
					self.graderThree = email
				end
			else
				self.graderTwo = email
			end
		else
			self.graderOne = email
		end
	end
end
