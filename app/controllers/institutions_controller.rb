class InstitutionsController < ApplicationController
	before_filter :authenticate_user!

	def index

		@search_form = params[:search_form].to_i
		@course_id = 0
		@text_course = @text_search = @search = nil

		if @search_form
			@search = params[:search]
			@course_id = params[:course_id].to_i
			if !@search.nil?
				@text_search = "and name like '%#{@search}%'"
			end
			if @course_id != 0
				@text_course = "and course_id = #{@course_id}"
			end
		end

		if @course_id == 0
			@institutions = Institution.where("1=1 #{@text_search}").paginate(:page => params[:page])
		else
			@institutions = Institution.joins(:course_options).where("1=1 #{@text_search} #{@text_course}").paginate(:page => params[:page])			
		end
		respond_to do |format|
			format.html #show.html.erb
			format.xml { render xml: @institutions }
			format.json { render json: @institutions }
		end		
	end

	def show
		#render nothing: true
		@institution = Institution.find(params[:id])
		@campus = Campu.where('institution_id = ?', @institution.id )
	end

	def new
		@institution = Institution.new
	end

	def create
		@institution = Institution.new(params[:institution].permit(:name, :website, :enrolment_fee))
		if @institution.save
			flash[:notice] = "Institution Created"
			redirect_to @institution
		else
			render "new"
		end
	end

	def edit
		@institution = Institution.find(params[:id])
	end

	def update
		@institution = Institution.find(params[:id])
		if @institution.update(params[:institution].permit(:name, :website, :enrolment_fee))
			flash[:notice] = "Institution Updated"
			redirect_to @institution
		else
			render "new"
		end
	end

	def destroy
 		Institution.find(params[:id]).destroy
 		flash[:notice] = "Institution Deleted"
		redirect_to institutions_path
	end

	def only_admins_create_update_company
		#redirect_to companies_path, :alert => "Only admins can create/update a company" unless current_user.admin
	end	
end
