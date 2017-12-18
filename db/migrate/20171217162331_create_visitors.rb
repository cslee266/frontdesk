class CreateVisitors < ActiveRecord::Migration[5.0]
  def change
    create_table :visitors do |t|
      t.string :name
      t.date :visit_day
      t.time :arrival_time
      t.string :car_plate
      t.timestamps
    end
  end
end
