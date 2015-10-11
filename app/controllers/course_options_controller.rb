class CourseOptionsController < ApplicationController
	before_filter :authenticate_user!

	def index
		@course_options = CourseOption.all.order('intake_date')
	end

	def show
		@course_option = CourseOption.find(params[:id])
	end	
	
	def new
		@course_option = CourseOption.new
	end

	def create
		@course_option = CourseOption.new(params[:course_option].permit(:institution_id, :course_id, :duration, :cost, :capacity, :intake_date, :more_information))
		if @course_option.save
			flash[:notice] = "Course Created"
			redirect_to @course_option
		else
			render "new"
		end
	end

	def edit
		@course_option = CourseOption.find(params[:id])
	end

	def update
		@course_option = CourseOption.find(params[:id])
		if @course_option.update(params[:course_option].permit(:institution_id, :course_id, :duration, :cost, :capacity, :intake_date, :more_information))
			#Usermailer.Courseupdated_email(@course).deliver
			flash[:notice] = "Course Option Updated"
			redirect_to @course_option
		else
			render "new"
		end
	end
end
