# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.string :answer
      t.references :question, foreign_key: true
      t.references :employee, foreign_key: true

      t.timestamps
    end
  end
end
