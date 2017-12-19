class AddStatusToMaintenance < ActiveRecord::Migration[5.0]
  def change
  	add_column :maintenances, :status, :integer, default: 0
  	add_column :maintenances, :user_id, :integer
  end
end
