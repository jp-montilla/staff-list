class HomepageController < ApplicationController
  before_action :authenticate_employee!
  def index
    @employees = Employee.where(role: 'Employee').order(name: :asc).page(params[:page]).per(5)
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
    if params[:edit_answer]
      @answer_edit = Answer.find(params[:edit_answer])
      @choices = Choice.all
      respond_to do |format|
        format.js {render 'edit.js.erb'}
        format.html
      end
    end
  end

  def update
    @answer = Answer.find(params[:id])
    if @answer.update(update_params)
      flash[:success] = 'Answer updated successfully.'
    else
      # redirect_to homepage_path(current_employee.id)
    end
    @employee = Employee.find(current_employee.id)
    @questions = Question.all
    @answers = Answer.where(employee_id: params[:id]) 
    respond_to do |format|
      format.js {render 'update.js.erb'}
      format.html
    end
  end





  private
    def set_params
      params.require(:answer).permit(:answer, :question_id, :employee_id)
    end
    def update_params
      params.require(:answer).permit(:answer)
    end

end
