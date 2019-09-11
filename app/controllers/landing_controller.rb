class LandingController < ApplicationController
  before_action :authenticate_employee!
  def index
    @employees = Employee.where(role: 'Employee')
  end
end
