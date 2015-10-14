class CourseIntakesController < ApplicationController

	def new
		@course_intake = CourseIntake.new
		@course_option = CourseOption.find(params[:course_option_id])
	end

	def create
		@course_intake = CourseIntake.new(params[:course_intake].permit(:course_option_id,:intake_date))
		@course_option = CourseOption.find(params[:course_intake][:course_option_id])
		if @course_intake.save
			flash[:notice] = "Course Intake Created"
			redirect_to @course_option
		else
			render "new"
		end
	end

	def edit
		@course_intake = CourseIntake.find(params[:id])
		@course_option = CourseOption.find(@course_intake.course_option_id)		
	end

	def update
		@course_intake = CourseIntake.find(params[:id])
		@course_option = CourseOption.find(params[:course_intake][:course_option_id])
		if @course_intake.update(params[:course_intake].permit(:course_option_id,:intake_date))
			flash[:notice] = "Course Intake Updated"
			redirect_to @course_option
		else
			render "new"
		end
	end

	def destroy
		@course_intake = CourseIntake.find(params[:id])
 		CourseIntake.find(params[:id]).destroy
 		@course_option = CourseOption.find(@course_intake.course_option_id)			
 		flash[:notice] = "Course Intake Deleted"
		redirect_to @course_option
	end

end
