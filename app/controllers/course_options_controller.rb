class CourseOptionsController < ApplicationController
	before_action :set_course_option, :only => [:show, :edit, :update, :destroy]
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
		@course_options = CourseOption.where("1=1 #{@text_course} #{@text_institution}")
		respond_to do |format|
			format.html #show.html.erb
			format.xml { render xml: @course_options }
			format.json { render json: @course_options }	
		end	
	end

	def show
		@course_intakes = CourseIntake.where('course_option_id = ?',params[:id]).order('intake_date')
	end	
	
	def new
		@course_option = CourseOption.new
	end

	def create
		@course_option = CourseOption.new(course_option_params)
		if @course_option.save
			flash[:notice] = "Course Created"
			redirect_to @course_option
		else
			render "new"
		end
	end

	def edit
	end

	def update
		if @course_option.update(course_option_params)
			flash[:notice] = "Course Option Updated"
			redirect_to @course_option
		else
			render "edit"
		end
	end

	def destroy
 		@course_option.destroy
 		flash[:notice] = "Course Option Deleted"
		redirect_to course_options_path
	end

	private
	def course_option_params
 		params.require(:course_option).permit(:institution_id, :course_id, :cost, :material_fee, :more_information, :payments, :frequency_number, :frequency_type_id)
	end	

	def set_course_option
		@course_option = CourseOption.find(params[:id])
	end	


end
