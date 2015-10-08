class RemoveNameCourseOptions < ActiveRecord::Migration
  def change
  	remove_column :course_options, :name
  end
end
