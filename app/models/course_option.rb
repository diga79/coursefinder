class CourseOption < ActiveRecord::Base
	belongs_to :institution
	belongs_to :course
	has_many :course_intakes

	validates :cost, numericality: { only_integer: true, greater_than: 0 }
	validates :duration, numericality: { only_integer: true, greater_than: 0 }

	validates :institution_id, presence: true
	validates :course_id, presence: true


end
