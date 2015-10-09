class Institution < ActiveRecord::Base
    has_many :courses, :through => :course_options
    has_many :course_options

	validates :name, length: { minimum: 2 }
	validates :enrolment_fee, numericality: { only_integer: true, greater_than: 0 }	

	def to_s
		"#{name}"
	end
end
