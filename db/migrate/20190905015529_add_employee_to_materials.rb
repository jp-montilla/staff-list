class AddEmployeeToMaterials < ActiveRecord::Migration[5.1]
  def change
    add_reference :materials, :employee, foreign_key: true
  end
end
