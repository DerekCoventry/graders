class Applicant < ApplicationRecord
	has_many :schedule
	def self.search(search)
	  if search
	    where('name LIKE ?', "%#{search}%")
	  else
	    unscoped
	  end
	end
end
