class RenameShowInListInQuestions < ActiveRecord::Migration[5.1]
  def change
    rename_column :questions, :view_in_list, :view_to_list
  end
end
