# frozen_string_literal: true

class ChangeProfilePictureToBeJsonInEmployees < ActiveRecord::Migration[5.1]
  def change
    change_column :employees, :profile_picture, :json
  end
end
