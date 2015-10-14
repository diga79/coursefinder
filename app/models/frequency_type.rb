class FrequencyType < ActiveRecord::Base
	has_many :course_options

	def to_s
		name
	end
end
