class CampusController < ApplicationController
	before_action :set_campu, :only => [:show, :edit, :update, :destroy]
	before_action :set_institution, :only => [:edit, :update, :destroy]
	before_filter :authenticate_user!

	def index 
		@campus = Campu.all.paginate(:page => params[:page])
		respond_to do |format|
			format.html #show.html.erb
			format.xml { render xml: @campus }
			format.json { render json: @campus }
		end
	end

	def show
	end

	def new
		@campu = Campu.new
		@institution = Institution.find(params[:institution_id])
	end

	def create
		@campu = Campu.new(campu_params)
		@institution = Institution.find(params[:campu][:institution_id])
		if @campu.save
			flash[:notice] = "Campus Created"
			redirect_to @institution
		else
			render "new"
		end
	end

	def edit
	end

	def update
		if @campu.update(campu_params)
			flash[:notice] = "Campus Updated"
			redirect_to @institution
		else
			render "edit"
		end
	end

	def destroy
 		@campu.destroy
 		flash[:notice] = "Campus Deleted"
		redirect_to @institution
	end	

	private
	def campu_params
 		params.require(:campu).permit(:institution_id,:city_id, :name, :address, :state, :country_id, :phone)
	end	

	def set_campu
		@campu = Campu.find(params[:id])
	end	

	def set_institution
		@institution = Institution.find(@campu.institution_id)
	end	

end
