# frozen_string_literal: true

class RenameUsernameInEmployees < ActiveRecord::Migration[5.1]
  def change
    rename_column :employees, :username, :name
  end
end
