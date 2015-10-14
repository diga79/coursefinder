class CitiesController < ApplicationController
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
		@city = City.find(params[:id])
	end

	def new
		@city = City.new
	end

	def create
		@city = City.new(params[:city].permit(:name, :description))
		if @city.save
			flash[:notice] = "City Created"
			redirect_to @city
		else
			render "new"
		end
	end

	def edit
		@city = City.find(params[:id])
	end

	def update
		@city = City.find(params[:id])
		if @city.update(params[:city].permit(:name, :description))
			flash[:notice] = "City Updated"
			redirect_to @city
		else
			render "new"
		end
	end

	def destroy
 		City.find(params[:id]).destroy
 		flash[:notice] = "City Deleted"
		redirect_to cities_path
	end	
end
