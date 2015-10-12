class CourseOption < ActiveRecord::Base
	belongs_to :institution
	belongs_to :course
	has_many :applications
	has_many :students, :through => :applications

	validates :material_fee, numericality: { only_integer: true, greater_than: 0 }
	validates :cost, numericality: { only_integer: true, greater_than: 0 }
	validates :duration, numericality: { only_integer: true, greater_than: 0 }
	validates :intake_date, length: { minimum: 5 }
	validates :capacity, numericality: { only_integer: true, greater_than: 0, less_than: 26 }
	validates :institution_id, presence: true
	validates :course_id, presence: true

	def intake_date_field
		intake_date.strftime('%d/%m/%Y')
	end

	def course_name
		#c = Course.find(cid)
		"#{intake_date_field} - #{institution.name} - #{course.name}" 
	end
end
