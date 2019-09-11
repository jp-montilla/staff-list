class HomepageController < ApplicationController
  before_action :authenticate_employee!
  def index
    @employees = Employee.where(role: 'Employee')
    @questions = Question.where(view_to_list: 1)

  end

  def show
    @employee = Employee.find(params[:id])
    @questions = Question.all
  end
end
