class FrequencyType < ActiveRecord::Base
	has_many :course_options
    validates :name, length: { minimum: 3 }
	
	def to_s
		name
	end
end
