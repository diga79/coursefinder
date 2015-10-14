class RemoveFieldsCourseOptions < ActiveRecord::Migration
  def change
  	remove_column :course_options, :capacity
  	remove_column :course_options, :duration
  	remove_column :course_options, :intake_date
  end
end
