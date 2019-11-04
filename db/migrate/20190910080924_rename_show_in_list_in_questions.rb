# frozen_string_literal: true

class RenameShowInListInQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :view_in_list, :integer
    rename_column :questions, :view_in_list, :view_to_list
  end
end
