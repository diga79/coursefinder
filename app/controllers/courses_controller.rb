class CoursesController < ApplicationController
	#before_filter :authenticate_user!

	def index
		@courses = Course.all
		respond_to do |format|
			format.html
			format.csv { send_data Course.export1_csv(@courses), type: 'text/csv; charset=utf-8; header=present', disposition: 'attachment; filename=courses.csv' }
		end
	end

	def show
		@course = Course.find(params[:id])
		@course_options = CourseOption.find_by course_id: @course
	end

	def new
		@course = Course.new
	end

	def create
		@course = Course.new(params[:Course].permit(:name))
		if @course.save
			flash[:notice] = "Course Created"
			redirect_to @course
		else
			render "new"
		end
	end

	def edit
		@course = Course.find(params[:id])
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
