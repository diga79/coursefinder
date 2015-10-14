class CourseOption < ActiveRecord::Base
	belongs_to :institution
	belongs_to :course
	belongs_to :frequency_type

	has_many :applications
	has_many :course_intakes
	has_many :students, :through => :applications

	validates :material_fee, numericality: { only_integer: true, greater_than: 0 }
	validates :cost, numericality: { only_integer: true, greater_than: 0 }
	validates :payments, numericality: { only_integer: true, greater_than: 0 }
	validates :frequency_number, numericality: { only_integer: true, greater_than: 0 }

	validates :institution_id, presence: true
	validates :course_id, presence: true
	validates :frequency_type_id, presence: true

	def course_name
		"#{course.name} - #{institution.name}" 
	end
end
