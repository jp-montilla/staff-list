class Material < ApplicationRecord
  # belongs_to :employee
  # has_one :assigned
  # has_one :employee, through: :assigned
  belongs_to :employee, optional: true

  validates :employee_id, presence: false
end