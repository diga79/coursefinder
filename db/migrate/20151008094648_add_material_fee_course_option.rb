class AddMaterialFeeCourseOption < ActiveRecord::Migration
  def change
	add_column :course_options, :material_fee, :integer  	
  end
end
