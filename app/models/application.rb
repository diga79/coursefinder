class Application < ActiveRecord::Base
	belongs_to :course_intake
	belongs_to :student

	validates :start_date, length: { minimum: 5 }
	validates :course_intake_id, presence: true
    validates :student_id, presence: true	
end
