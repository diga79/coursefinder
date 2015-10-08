class InstitutionsController < ApplicationController
	#before_filter :authenticate_user!

	def index
		@institutions = Institution.all
	end

	def show
		#render nothing: true
		@institution = Institution.find(params[:id])
		respond_to do |format|
			format.html #show.html.erb
			format.xml { render xml: @institution }
			format.json { render json: @institution }
		end
	end

	def new
		@institution = Institution.new
	end

	def create
		@institution = Institution.new(params[:institution].permit(:name))
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
		if @institution.update(params[:institution].permit(:name))
			flash[:notice] = "Institution Updated"
			redirect_to @institution
		else
			render "new"
		end
	end

	def only_admins_create_update_company
		#redirect_to companies_path, :alert => "Only admins can create/update a company" unless current_user.admin
	end	
end
