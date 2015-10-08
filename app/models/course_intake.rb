class CourseIntake < ActiveRecord::Base
	belongs_to :course_option
	has_many :applications
	has_many :students, :through => :applications

	validates :intake_date, length: { minimum: 5 }
	validates :capacity, numericality: { only_integer: true, greater_than: 0, less_than: 26 }
	validates :course_option_id, presence: true

end