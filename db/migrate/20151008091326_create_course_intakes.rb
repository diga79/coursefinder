class CreateCourseIntakes < ActiveRecord::Migration
  def change
    create_table :course_intakes do |t|
	  t.integer :course_option_id 
	  t.datetime :intake_date
	  t.integer :capacity 
      t.timestamps null: false
    end
  end
end
