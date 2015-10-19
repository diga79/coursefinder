class CourseIntake < ActiveRecord::Base
	belongs_to :course_option

	validates :course_option_id, presence: true

	def to_s
		"#{course_option.course.name} #{course_option.institution.name} - #{intake_date_field}" 
	end
	def intake_date_field
		intake_date.strftime('%d/%m/%Y')
	end	
end
