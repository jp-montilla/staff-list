# frozen_string_literal: true

# rubocop:disable Naming/PredicateName

# Employee Policy
class EmployeePolicy < ApplicationPolicy
  def is_admin?
    user.role != 'Admin'
  end
end
# rubocop:enable Naming/PredicateName
