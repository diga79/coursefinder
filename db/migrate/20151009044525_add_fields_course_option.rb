class AddFieldsCourseOption < ActiveRecord::Migration
  def change
  	add_column :course_options, :intake_date, :datetime  	
  	add_column :course_options, :capacity, :integer  	
  end
end
