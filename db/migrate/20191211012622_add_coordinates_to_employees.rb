class AddCoordinatesToEmployees < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :lat, :float
    add_column :employees, :long, :float
  end
end
