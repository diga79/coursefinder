class StudentsController < ApplicationController
	before_action :set_student, :only => [:show, :edit, :update, :destroy]
	before_filter :authenticate_user!

	def index
		@search_form = params[:search_form].to_i
		@text_search = @search = nil

		if @search_form
			@search = params[:search]
			if !@search.nil?
				@text_search = "and (first_name like '%#{@search}%' or last_name like '%#{@search}%')"
			end
		end
		@students = Student.where("1=1 #{@text_search}")
	end

	def show
	end

	def new
		@student = Student.new
	end

	def edit
	end

	def create
		@student = Student.new(student_params)
		if @student.save
			flash[:notice] = "Student Created"
			redirect_to @student
		else
			render "new"
		end
	end

	def update
		if @student.update(student_params)
			#Usermailer.Courseupdated_email(@course).deliver
			flash[:notice] = "Student Updated"
			redirect_to @student
		else
			render "edit"
		end
	end

	def destroy
 		@student.destroy
 		flash[:notice] = "Student Deleted"
		redirect_to students_path
	end

	private
	def student_params
 		params.require(:student).permit(:first_name, :last_name, :email, :phone, :date_birth)
	end	

	def set_student
		@student = Student.find(params[:id])
	end	
end
