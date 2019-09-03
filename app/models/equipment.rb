class Equipment < ApplicationRecord
  has_one :employee, through: :assigned
end
