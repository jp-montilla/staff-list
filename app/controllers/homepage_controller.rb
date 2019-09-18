class HomepageController < ApplicationController
  before_action :authenticate_employee!
  def index
    @employees = Employee.where(role: 'Employee').order(name: :asc).page(params[:page]).per(3)
    #@products = Product.order(created_at: :desc).page(params[:page]).per(3)
    
    @questions = Question.where(view_to_list: 1)
    @answers = Answer.all
    respond_to do |format|
      format.js {render 'index.js.erb'}
      format.html
    end
  end

  def show
    @employee = Employee.find(params[:id])
    @questions = Question.all
    @answers = Answer.where(employee_id: params[:id])
    @answer = Answer.new
  end
end
