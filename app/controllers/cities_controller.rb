class CitiesController < ApplicationController
	before_action :set_city, :only => [:show, :edit, :update, :destroy]
	before_filter :authenticate_user!

	def index
		@cities = City.all.paginate(:page => params[:page])
		respond_to do |format|
			format.html #show.html.erb
			format.xml { render xml: @cities }
			format.json { render json: @cities }
			format.csv { send_data City.export1_csv(@cities), type: 'text/csv; charset=utf-8; header=present', disposition: 'attachment; filename=cities.csv' }
		end
	end

	def show
	end

	def new
		@city = City.new
	end

	def create
		@city = City.new(city_params)
		if @city.save
			flash[:notice] = "City Created"
			redirect_to @city
		else
			render "new"
		end
	end

	def edit
	end

	def update
		if @city.update(city_params)
			flash[:notice] = "City Updated"
			redirect_to @city
		else
			render "new"
		end
	end

	def destroy
 		@city.destroy
 		flash[:notice] = "City Deleted"
		redirect_to cities_path
	end	

	private
	def city_params
 		params.require(:city).permit(:name)
	end	

	def set_city
		@city = City.find(params[:id])
	end	

end
