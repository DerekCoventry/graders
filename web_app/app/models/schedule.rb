class Schedule < ApplicationRecord
	belongs_to :applicant,
		:foreign_key => 'id'
end
