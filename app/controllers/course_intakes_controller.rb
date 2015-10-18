class CourseIntakesController < ApplicationController
	before_action :set_course_intake, :only => [:show, :edit, :update, :destroy]
	#before_action :set_course_option_new, :only => [:new, :create]
	before_action :set_course_option, :only => [:edit, :update, :destroy]
	before_filter :authenticate_user!

	def new
		@course_intake = CourseIntake.new
		@course_option = CourseOption.find(params[:course_option_id])
	end

	def create
		@course_intake = CourseIntake.new(course_intake_params)
		@course_option = CourseOption.find(params[:course_intake][:course_option_id])
		if @course_intake.save
			flash[:notice] = "Course Intake Created"
			redirect_to @course_option
		else
			render "new"
		end
	end

	def edit
	end

	def update
		if @course_intake.update(course_intake_params)
			flash[:notice] = "Course Intake Updated"
			redirect_to @course_option
		else
			render "edit"
		end
	end

	def destroy
 		@course_intake.destroy
 		flash[:notice] = "Course Intake Deleted"
		redirect_to @course_option
	end
	private

	def course_intake_params
 		params.require(:course_intake).permit(:course_option_id,:intake_date)
	end	

	def set_course_intake
		@course_intake = CourseIntake.find(params[:id])
	end	

	#def set_course_option_new
	#	@course_option = CourseOption.find(params[:course_option_id])
	#end	

	def set_course_option
		@course_option = CourseOption.find(@course_intake.course_option_id)
	end	
end
