class CreateCourseOptions < ActiveRecord::Migration
  def change
    create_table :course_options do |t|
      t.string :name
      t.integer :institution_id
      t.integer :course_id 
      t.string :more_information 
      t.integer :cost
      t.integer :duration  
      t.timestamps null: false
    end
  end
end
