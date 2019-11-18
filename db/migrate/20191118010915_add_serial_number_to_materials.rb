class AddSerialNumberToMaterials < ActiveRecord::Migration[5.1]
  def change
    add_column :materials, :serial_number, :string
  end
end
