class ApplicationsController < ApplicationController
	before_filter :authenticate_user!

	def index
		@applications = Application.all
	end

	def show
		@application = Application.find(params[:id])
	end

	def new
		@application = Application.new
		@student = Student.new
	end

	def create
		@application = Application.new(params[:application].permit(:student_id, :course_option_id, :start_date, :payment_due_date, :payment_date))
		if @application.save
			flash[:notice] = "Application Created"
			redirect_to @application
		else
			render "new"
		end
	end

	def edit
		@application = Application.find(params[:id])
	end

	def update
		@application = Application.find(params[:id])
		if @application.update(params[:application].permit(:student_id, :course_option_id, :start_date, :payment_due_date, :payment_date))
			#Usermailer.Courseupdated_email(@course).deliver
			flash[:notice] = "Application Updated"
			redirect_to @application
		else
			render "new"
		end
	end


end
