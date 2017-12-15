class CreateUnits < ActiveRecord::Migration[5.0]
  def change
    create_table :units do |t|
      t.string :residence
      t.string :block
      t.integer :floor
      t.string :unit_number
      t.string :unit_type

      t.timestamps
    end
  end
end
