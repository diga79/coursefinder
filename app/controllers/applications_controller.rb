class ApplicationsController < ApplicationController
	before_filter :authenticate_user!

	def index
		@applications = Application.all.paginate(:page => params[:page])
	end

	def show
		@application = Application.find(params[:id])
		@total_cost = @application.course_option.cost + @application.course_option.institution.enrolment_fee + @application.course_option.material_fee
	end

	def new
		if (params[:student_id])
			@student = Student.find(params[:student_id])
		else
			@student = Student.new
		end

		if (params[:course_option_id])
			@course_option = CourseOption.find(params[:course_option_id])
		else
			@course_option = CourseOption.new
		end

		@application = Application.new
		@application.student = @student
		@application.course_option = @course_option
	end

	def create
		@application = Application.new(params[:application].permit(:student_id, :course_option_id, :start_date, :payment_due_date, :payment_date, :total_paid))
		if @application.save
			flash[:notice] = "Application Created"
			redirect_to @application
		else
			render "new"
		end
	end

	def edit
		@application = Application.find(params[:id])
		@total_cost = @application.course_option.cost + @application.course_option.institution.enrolment_fee + @application.course_option.material_fee		
	end

	def update
		@application = Application.find(params[:id])
		if @application.update(params[:application].permit(:student_id, :course_option_id, :start_date, :payment_due_date, :payment_date, :total_paid))
			#Usermailer.Courseupdated_email(@course).deliver
			flash[:notice] = "Application Updated"
			redirect_to @application
		else
			render "new"
		end
	end

	def destroy
 		Application.find(params[:id]).destroy
 		flash[:notice] = "Application Deleted"
		redirect_to applications_path
	end
end
