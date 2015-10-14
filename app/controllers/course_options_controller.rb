class CourseOptionsController < ApplicationController
	before_filter :authenticate_user!

	def index

		@search_form = params[:search_form].to_i
		@institution_id = @course_id = 0
		@text_course = @text_institution = nil

		if @search_form
			@institution_id = params[:institution_id].to_i
			@course_id = params[:course_id].to_i
			if @course_id != 0
				@text_course = "and course_id = #{@course_id}"
			end
			if @institution_id != 0
				@text_institution = "and institution_id = #{@institution_id}"
			end
		end
		@course_options = CourseOption.where("1=1 #{@text_course} #{@text_institution}").paginate(:page => params[:page])
		respond_to do |format|
			format.html #show.html.erb
			format.xml { render xml: @course_options }
			format.json { render json: @course_options }	
		end	
	end

	def show
		@course_option = CourseOption.find(params[:id])
		@course_intakes = CourseIntake.where('course_option_id = ?',params[:id]).order('intake_date')
	end	
	
	def new
		@course_option = CourseOption.new
	end

	def create
		@course_option = CourseOption.new(params[:course_option].permit(:institution_id, :course_id, :cost, :material_fee, :more_information, :payments, :frequency_number, :frequency_type_id))
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
		if @course_option.update(params[:course_option].permit(:institution_id, :course_id, :cost, :material_fee, :more_information, :payments, :frequency_number, :frequency_type_id))
			#Usermailer.Courseupdated_email(@course).deliver
			flash[:notice] = "Course Option Updated"
			redirect_to @course_option
		else
			render "new"
		end
	end

	def destroy
 		CourseOption.find(params[:id]).destroy
 		flash[:notice] = "Course Option Deleted"
		redirect_to course_options_path
	end

end
