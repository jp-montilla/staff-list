class AddSessionLimitableToEmployees < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :unique_session_id, :string, limit: 20
  end
end
