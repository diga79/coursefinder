class CreateFrequencyTypes < ActiveRecord::Migration
  def change
    create_table :frequency_types do |t|
      t.string :name 
      t.timestamps null: false
    end
  end
end
