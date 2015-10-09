class RenameCourseIntakeIdInApplications < ActiveRecord::Migration
  def change
  	rename_column :applications, :course_intake_id, :course_option_id
  end
end
