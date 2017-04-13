class Schedule < ApplicationRecord
	belongs_to :user,
		:foreign_key => 'email'
end
