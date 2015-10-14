class CampusController < ApplicationController

	def index 
		@campus = Campu.all.paginate(:page => params[:page])
		respond_to do |format|
			format.html #show.html.erb
			format.xml { render xml: @campus }
			format.json { render json: @campus }
	end
		
	end

	def show
		@campu = Campu.find(params[:id])
	end

	def new
		@campu = Campu.new
		@insttitution = Institution.find(params[:institution_id])
	end

	def create
		@campu = Campu.new(params[:campu].permit(:institution_id,:city_id, :name, :address, :state, :country_id, :phone))
		@institution = Institution.find(params[:campu][:institution_id])
		if @campu.save
			flash[:notice] = "Campus Created"
			redirect_to @institution
		else
			render "new"
		end
	end

	def edit
		@campu = Campu.find(params[:id])
		@institution = Institution.find(@campu.institution.id)		
	end

	def update
		@campu = Campu.find(params[:id])
		@institution = Institution.find(@campu.institution_id)
		if @campu.update(params[:campu].permit(:institution_id,:city_id, :name, :address, :state, :country_id, :phone))
			flash[:notice] = "Campus Updated"
			redirect_to @institution
		else
			render "new"
		end
	end

	def destroy
		@campu = Campu.find(params[:id])
 		Campu.find(params[:id]).destroy
 		@institution = Institution.find(@campu.institution_id)			
 		flash[:notice] = "Campus Deleted"
		redirect_to @institution
	end	

end
