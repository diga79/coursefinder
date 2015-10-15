class CountriesController < ApplicationController
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
		@country = Country.find(params[:id])
	end

	def new
		@country = Country.new
	end

	def create
		@country = Country.new(params[:country].permit(:name, :short_name))
		if @country.save
			flash[:notice] = "City Created"
			redirect_to @country
		else
			render "new"
		end
	end

	def edit
		@country = Country.find(params[:id])
	end

	def update
		@country = Country.find(params[:id])
		if @country.update(params[:country].permit(:name, :short_name))
			flash[:notice] = "Country Updated"
			redirect_to @country
		else
			render "new"
		end
	end

	def destroy
 		Country.find(params[:id]).destroy
 		flash[:notice] = "Country Deleted"
		redirect_to countries_path
	end	

end
