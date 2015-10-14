class FrequencyTypesController < ApplicationController
	before_filter :authenticate_user!

	def index
		@frequency_types = FrequencyType.all.paginate(:page => params[:page])
		respond_to do |format|
			format.html #show.html.erb
			format.xml { render xml: @frequency_types }
			format.json { render json: @frequency_types }
			format.csv { send_data FrequencyType.export1_csv(@frequency_types), type: 'text/csv; charset=utf-8; header=present', disposition: 'attachment; filename=courses.csv' }
		end
	end

	def show
		@frequency_type = FrequencyType.find(params[:id])
	end

	def new
		@frequency_type = FrequencyType.new
	end

	def create
		@frequency_type = FrequencyType.new(params[:frequency_type].permit(:name))
		if @frequency_type.save
			flash[:notice] = "Frequency Type Created"
			redirect_to @frequency_type
		else
			render "new"
		end
	end

	def edit
		@frequency_type = FrequencyType.find(params[:id])
	end

	def update
		@frequency_type = FrequencyType.find(params[:id])
		if @frequency_type.update(params[:frequency_type].permit(:name))
			flash[:notice] = "Frequency Type Updated"
			redirect_to @frequency_type
		else
			render "new"
		end
	end

	def destroy
 		FrequencyType.find(params[:id]).destroy
 		flash[:notice] = "Frequency Type Deleted"
		redirect_to frequency_types_path
	end	

end
