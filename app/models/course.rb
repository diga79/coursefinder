class Course < ActiveRecord::Base
	has_many :course_options
	has_many :institutions, :through => :course_options

	validates :name, length: { minimum: 3 }

	def to_s
		name
	end
end
