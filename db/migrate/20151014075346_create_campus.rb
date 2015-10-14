class CreateCampus < ActiveRecord::Migration
  def change
    create_table :campus do |t|
      t.string :name 
      t.string :address 
      t.integer :city_id 
      t.string :postal   
      t.string :state       
      t.string :country_id                       
      t.integer :phone       
      t.timestamps null: false
    end
  end
end
