class HomepageController < ApplicationController
  before_action :authenticate_employee!
  def index
    @employees = Employee.where(role: 'Employee')
  end

  def show
  end
end
