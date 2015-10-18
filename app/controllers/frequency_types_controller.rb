class FrequencyTypesController < ApplicationController
	before_action :set_frequency_type, :only => [:show, :edit, :update, :destroy]
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
	end

	def new
		@frequency_type = FrequencyType.new
	end

	def create
		@frequency_type = FrequencyType.new(frequency_type_params)
		if @frequency_type.save
			flash[:notice] = "Frequency Type Created"
			redirect_to @frequency_type
		else
			render "new"
		end
	end

	def edit
	end

	def update
		if @frequency_type.update(frequency_type_params)
			flash[:notice] = "Frequency Type Updated"
			redirect_to @frequency_type
		else
			render "edit"
		end
	end

	def destroy
 		@frequency_type.destroy
 		flash[:notice] = "Frequency Type Deleted"
		redirect_to frequency_types_path
	end	

	private
	def frequency_type_params
 		params.require(:frequency_type).permit(:name)
	end	

	def set_frequency_type
		@frequency_type = FrequencyType.find(params[:id])
	end	

end
