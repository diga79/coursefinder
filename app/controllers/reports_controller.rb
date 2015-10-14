class ReportsController < ApplicationController
	before_filter :authenticate_user!
	
	@@list_reports = 
	[
		"Enrolments per Period", 
		"Popular Courses", 
		"Birthday list", 
		"Possible Payments" 
	]
	@@filter_days = 90

	def report
		@list_reports = @@list_reports
		@filter_days = @@filter_days

		@search_form = params[:search_form].to_i
		@date1 = Date.today 
		@date2 = Date.today + @@filter_days
		@institution_id = @course_id = 0
		@month_id =  Date.today.mon

		if (params[:id])
			@id = params[:id].to_i
			@list = @list_reports.at(@id)

			if @search_form == 1
				if @id == 0 || @id == 3
					@date1 = Date.civil(params[:date1][:year].to_i, params[:date1][:month].to_i, params[:date1][:day].to_i)
					@date2 = Date.civil(params[:date2][:year].to_i, params[:date2][:month].to_i, params[:date2][:day].to_i)
					@institution_id = params[:report][:institution_id].to_i
					@course_id = params[:report][:course_id].to_i
				elsif @id = 2
					@month_id = params[:month_id]
				end
			end
			@institution_text = "institution_id = #{@institution_id} and "
			@course_text = "course_id = #{@course_id} and "

			if @id == 0 
				@enrolments = Application.joins(:course_option).where("#{ @institution_text if @institution_id > 0 }#{ @course_text if @course_id > 0 }start_date between :start_date AND :end_date",
  {start_date: @date1, end_date: @date2} )
				respond_to do |format|
					format.html #show.html.erb
					format.xml { render xml: @enrolments }
					format.json { render json: @enrolments }
				end		


			elsif @id == 1
				@courses = CourseOption.select("courses.name").joins(:applications, :course).group('courses.name').order('count(*) desc').count
				respond_to do |format|
					format.html #show.html.erb
					format.xml { render xml: @courses }
					format.json { render json: @courses }
				end		

			elsif @id == 2
				@students = Student.where("strftime('%m', date_birth) = '#{@month_id}'")
				respond_to do |format|
					format.html #show.html.erb
					format.xml { render xml: @students }
					format.json { render json: @students }
				end		

			elsif @id == 3
				@payments = Application.joins(:course_option).where("#{ @institution_text if @institution_id > 0 }#{ @course_text if @course_id > 0 }payment_due_date between :start_date AND :end_date", 
				 {start_date: @date1, end_date: @date2} )
				respond_to do |format|
					format.html #show.html.erb
					format.xml { render xml: @payments }
					format.json { render json: @payments }
				end		

			end
		else
			@id = -1
			@list = @list_reports
		end
	end

	def filter_days
		@@filter_days
	end
end
