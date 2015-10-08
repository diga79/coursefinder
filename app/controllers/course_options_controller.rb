class CourseOptionsController < ApplicationController
	def new
		@course_options = CourseOption.new
	end

	def create
		@course_options = CourseOption.new(params[:Course].permit(:name))
		if @course.save
			flash[:notice] = "Course Created"
			redirect_to @course
		else
			render "new"
		end
	end

	def edit
		@course = CourseOption.find(params[:id])
	end

	def update
		@course = Course.find(params[:id])
		if @course.update(params[:Course].permit(:name))
			#Usermailer.Courseupdated_email(@course).deliver
			flash[:notice] = "Course Updated"
			redirect_to @course
		else
			render "new"
		end
	end
end
