class AddUserIdToVisitors < ActiveRecord::Migration[5.0]
  def change
  	add_column :visitors, :user_id, :integer
  end
end
