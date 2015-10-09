class Application < ActiveRecord::Base
	belongs_to :student
	belongs_to :course_option

	validates :start_date, length: { minimum: 5 }
	validates :course_option_id, presence: true
    validates :student_id, presence: true	

	def start_date_field
		start_date.strftime('%d/%m/%Y')
	end    

	def payment_due_date_field
		start_date.strftime('%d/%m/%Y')
	end    
	def payment_date_field
		start_date.strftime('%d/%m/%Y')
	end    

end
