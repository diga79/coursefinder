class CourseIntake < ActiveRecord::Base
	belongs_to :course_option

	validates :course_option_id, presence: true

	def intake_date_field
		intake_date.strftime('%d/%m/%Y')
	end	
end
