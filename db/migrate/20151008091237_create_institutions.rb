class CreateInstitutions < ActiveRecord::Migration
  def change
    create_table :institutions do |t|
      t.string :name
      t.string :website 
      t.integer :enrolment_fee
      t.integer :material_fee 
      t.timestamps null: false
    end
  end
end
