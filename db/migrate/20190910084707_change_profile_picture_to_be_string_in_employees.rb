# frozen_string_literal: true

class ChangeProfilePictureToBeStringInEmployees < ActiveRecord::Migration[5.1]
  def change
    change_column :employees, :profile_picture, :string
  end
end
