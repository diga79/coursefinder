class CourseIntakesController < ApplicationController
	def index
		@course_intakes = CourseIntake.all.find_by course_option_id: params[:id]
	end

	def show
		
	end
end
