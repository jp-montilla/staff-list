# frozen_string_literal: true

# Material Model
class Material < ApplicationRecord
  belongs_to :employee, optional: true

  validates :name, presence: true
  validates :material_type, presence: true
  validates :status, presence: true
  validates :employee_id, presence: false
  validates :serial_number, format: { with:/\d{3}\-\d{3}\-\d{3}/}, if: :material_type_license?

  attr_accessor :flag

  def material_type_license?
    material_type == 'License'
  end    

end
