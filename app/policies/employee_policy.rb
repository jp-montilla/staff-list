# frozen_string_literal: true

class EmployeePolicy < ApplicationPolicy
  def is_admin?
    user.role != 'Admin'
  end
end
