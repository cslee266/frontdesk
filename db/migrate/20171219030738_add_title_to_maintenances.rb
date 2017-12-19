class AddTitleToMaintenances < ActiveRecord::Migration[5.0]
  def change
  	add_column :maintenances, :title, :string
  	add_column :maintenances, :description, :string
  end
end
