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
      # @question = @answer_edit.question
      @choices = Choice.all
      respond_to do |format|
        format.js {render 'show.js.erb'}
        format.html
      end
    end
  end

  def edit
    @answer = Answer.find(params[:id])
    @choices = Choice.all
    respond_to do |format|
      format.js {render 'show.js.erb'}
      format.html
    end
  end

end
