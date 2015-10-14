class AddFieldsCourseOptions < ActiveRecord::Migration
  def change
  	add_column :course_options, :payments, :integer, :default => 1
  	add_column :course_options, :frequency_number, :integer, :default => 1
  	add_column :course_options, :frequency_type_id, :integer
  end
end
