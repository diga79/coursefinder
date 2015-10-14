class StudentsController < ApplicationController
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
		@students = Student.where("1=1 #{@text_search}").paginate(:page => params[:page])
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

	def destroy
 		Student.find(params[:id]).destroy
 		flash[:notice] = "Student Deleted"
		redirect_to students_path
	end

end
