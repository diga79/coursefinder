class CountriesController < ApplicationController
	before_action :set_country, :only => [:show, :edit, :update, :destroy]
	before_filter :authenticate_user!

	def index
		@countries = Country.all.paginate(:page => params[:page])
		respond_to do |format|
			format.html #show.html.erb
			format.xml { render xml: @countries }
			format.json { render json: @countries }
		end
	end

	def show
	end

	def new
		@country = Country.new
	end

	def create
		@country = Country.new(country_params)
		if @country.save
			flash[:notice] = "City Created"
			redirect_to @country
		else
			render "new"
		end
	end

	def edit
	end

	def update
		if @country.update(country_params)
			flash[:notice] = "Country Updated"
			redirect_to @country
		else
			render "edit"
		end
	end

	def destroy
 		@country.destroy
 		flash[:notice] = "Country Deleted"
		redirect_to countries_path
	end	

	private
	def country_params
 		params.require(:country).permit(:name, :short_name)
	end	

	def set_country
		@country = Country.find(params[:id])
	end	
end
