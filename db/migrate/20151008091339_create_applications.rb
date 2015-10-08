class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
	  t.integer :student_id 
	  t.integer :course_id
	  t.datetime :start_date 
	  t.datetime :payment_due_date
	  t.datetime :payment_date


      t.timestamps null: false
    end
  end
end
