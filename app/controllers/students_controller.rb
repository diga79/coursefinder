class StudentsController < ApplicationController
	#before_filter :authenticate_user!

	def index
		@students = Student.all
	end

	def show
		@student = Student.find(params[:id])
	end

	def new
		@student = Student.new
	end

	def edit
		@student = Student.find(params[:id])
	end

	def create
		@student = Student.new(params[:student].permit(:first_name, :last_name, :email, :phone, :date_birth))
		if @student.save
			flash[:notice] = "Student Created"
			redirect_to @student
		else
			render "new"
		end
	end

	def update
		@student = Student.find(params[:id])
		if @student.update(params[:student].permit(:first_name, :last_name, :email, :phone, :date_birth))
			#Usermailer.Courseupdated_email(@course).deliver
			flash[:notice] = "Student Updated"
			redirect_to @student
		else
			render "new"
		end
	end

end
