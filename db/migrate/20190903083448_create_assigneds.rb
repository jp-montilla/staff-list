class CreateAssigneds < ActiveRecord::Migration[5.1]
  def change
    create_table :assigneds do |t|
      t.references :employee, foreign_key: true
      t.references :equipment, foreign_key: true

      t.timestamps
    end
  end
end
