class CourseIntakesTable < ActiveRecord::Migration
  def up
    drop_table :course_intakes
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
