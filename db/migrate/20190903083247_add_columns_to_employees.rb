# frozen_string_literal: true

class AddColumnsToEmployees < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :username, :string
    add_column :employees, :profile_picture, :string
    add_column :employees, :role, :string
  end
end
