class Recommendation < ApplicationRecord
	validates :pemail, presence: true
	validates :semail, presence: true
end
