# frozen_string_literal: true

# Material Model
class Material < ApplicationRecord
  belongs_to :employee, optional: true

  validates :name, presence: true
  validates :material_type, presence: true
  validates :status, presence: true
  validates :employee_id, presence: false
end
