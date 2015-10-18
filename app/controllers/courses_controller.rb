class CoursesController < ApplicationController
	before_action :set_course, :only => [:show, :edit, :update, :destroy]
	before_filter :authenticate_user!

	def index
		@courses = Course.all.paginate(:page => params[:page])
		respond_to do |format|
			format.html #show.html.erb
			format.xml { render xml: @courses }
			format.json { render json: @courses }
			format.csv { send_data Course.export1_csv(@courses), type: 'text/csv; charset=utf-8; header=present', disposition: 'attachment; filename=courses.csv' }
		end
	end

	def show		
	end

	def new
		@course = Course.new
	end

	def create
		@course = Course.new(course_params)
		if @course.save
			flash[:notice] = "Course Created"
			redirect_to @course
		else
			render "new"
		end
	end

	def edit
	end

	def update
		if @course.update(course_params)
			#Usermailer.Courseupdated_email(@course).deliver
			flash[:notice] = "Course Updated"
			redirect_to @course
		else
			render "new"
		end
	end

	def destroy
 		@course.destroy
 		flash[:notice] = "Course Deleted"
		redirect_to courses_path
	end	

	private
	def course_params
 		params.require(:course).permit(:name, :description)
	end	

	def set_course
		@course = Course.find(params[:id])
	end	
end
