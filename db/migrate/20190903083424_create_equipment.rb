class CreateEquipment < ActiveRecord::Migration[5.1]
  def change
    create_table :equipment do |t|
      t.string :name
      t.string :equipment_type
      t.string :status

      t.timestamps
    end
  end
end
