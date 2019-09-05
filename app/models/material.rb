class Material < ApplicationRecord
  # belongs_to :employee
  has_one :assigned
  has_one :employee, through: :assigned

end