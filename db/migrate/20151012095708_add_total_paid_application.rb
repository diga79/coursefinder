class AddTotalPaidApplication < ActiveRecord::Migration
  def change
  	add_column :applications, :total_paid, :integer, :default => 0
  end
end
