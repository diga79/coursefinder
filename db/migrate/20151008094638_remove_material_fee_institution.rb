class RemoveMaterialFeeInstitution < ActiveRecord::Migration
  def change
  	remove_column :institutions, :material_fee
  end
end
