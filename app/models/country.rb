class Country < ActiveRecord::Base
	has_many :campus

	def to_s
		name
	end	
end
