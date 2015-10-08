class RenameCourseIdApplication < ActiveRecord::Migration
  def change
  	rename_column :applications, :course_id, :course_intake_id
  end
end
