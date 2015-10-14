class RenameCountryIdCampus < ActiveRecord::Migration
  def change
  		remove_column :campus, :country_id
  		add_column :campus, :country_id, :integer  
  end
end
