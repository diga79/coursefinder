class City < ActiveRecord::Base
	has_many :campus
	validates :name, length: { minimum: 3 }

	def to_s
		name
	end
end
