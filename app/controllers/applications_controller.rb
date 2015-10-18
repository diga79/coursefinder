class ApplicationsController < ApplicationController
	before_action :set_application, :only => [:show, :edit, :update, :destroy]
	before_filter :authenticate_user!

	def index
		@search_form = params[:search_form].to_i
		@institution_id = @course_id = 0
		@search = @text_course = @text_institution = nil

		if @search_form
			@institution_id = params[:institution_id].to_i
			@course_id = params[:course_id].to_i
			@search = params[:search]
			if !@search.nil?
				@text_search = "and (first_name like '%#{@search}%' or last_name like '%#{@search}%')"
			end			
			if @course_id != 0
				@text_course = "and course_id = #{@course_id}"
			end
			if @institution_id != 0
				@text_institution = "and institution_id = #{@institution_id}"
			end
		end
		@applications = Application.joins(:course_option, :student).where("1=1 #{ @text_institution } #{ @text_course } #{ @text_search }") .paginate(:page => params[:page])
		respond_to do |format|
			format.html #show.html.erb
			format.xml { render xml: @applications }
			format.json { render json: @applications }
		end

	end

	def show
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
		@application = Application.new(application_params)
		if @application.save
			flash[:notice] = "Application Created"
			redirect_to @application
		else
			render "new"
		end
	end

	def edit
		@total_cost = @application.course_option.cost + @application.course_option.institution.enrolment_fee + @application.course_option.material_fee		
	end

	def update
		if @application.update(application_params)
			flash[:notice] = "Application Updated"
			redirect_to @application
		else
			render "edit"
		end
	end

	def destroy
 		@application.destroy
 		flash[:notice] = "Application Deleted"
		redirect_to applications_path
	end

	private
	def application_params
 		params.require(:application).permit(:student_id, :course_option_id, :start_date, :payment_due_date, :payment_date, :total_paid)
	end	

	def set_application
		@application = Application.find(params[:id])
	end	

end
