class ReportsController < ApplicationController
	before_filter :authenticate_user!
	
	@@list_reports = 
	[
		"Enrolments per Period", 
		"Popular Courses", 
		"Birthday list", 
		"Possible Payments" 
	]

	def report
		@list_reports = @@list_reports
		@weeks = 60 * 60 * 24 * 7
		if (params[:id])
			@id = params[:id].to_i
			@list = @list_reports.at(@id)

			if @id == 0 
				@search_form = params[:search_form].to_i
				if @search_form == 1
					@date1 = Date.civil(params[:date1][:year].to_i, params[:date1][:month].to_i, params[:date1][:day].to_i)
					
					@date2 = Date.civil(params[:date2][:year].to_i, params[:date2][:month].to_i, params[:date2][:day].to_i)
				else
					#@search_form = params[:search_form]
					@date1 = Date.today 
					@date2 = Date.today + 90
				end

				@enrolments = Application.where("start_date between :start_date AND :end_date",
  {start_date: @date1, end_date: @date2} )

			elsif @id == 1
				@courses = CourseOption.select("courses.name").joins(:applications, :course).group('courses.name').order('count(*) desc').count
			elsif @id == 2
				@students = Student.all
				#where ('month(date_birth) = ', Date.today.month )
			elsif @id == 3
				@search_form = params[:search_form].to_i
				if @search_form == 1
					@date1 = Date.civil(params[:date1][:year].to_i, params[:date1][:month].to_i, params[:date1][:day].to_i)
					
					@date2 = Date.civil(params[:date2][:year].to_i, params[:date2][:month].to_i, params[:date2][:day].to_i)
				else
					#@search_form = params[:search_form]
					@date1 = Date.today 
					@date2 = Date.today + 90
				end
				@payments = Application.all.where("payment_due_date between :start_date AND :end_date",
  {start_date: @date1, end_date: @date2} )
			end

		else
			@id = -1
			@list = @list_reports
		end
	end

end
