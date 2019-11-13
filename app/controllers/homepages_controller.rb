# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength

# rubocop:disable Metrics/LineLength

# Landing Page controller
class HomepagesController < ApplicationController
  before_action :authenticate_employee!
  before_action :fetch_index_data, only: [:index]
  before_action :fetch_create_data, only: [:create]
  before_action :fetch_update_data, only: [:update]
  before_action :fetch_password_data, only: [:update_password]
  def index
    @answers = Answer.all
    respond_to do |format|
      format.js { render 'index.js.erb' }
      format.html
    end
  end

  def show
    @employee_detail = current_employee
    @employee = Employee.find(params[:id])
    @answers = Answer.where(employee_id: params[:id])
    @questions = Question.all
    @answered = @answers.count
    @unanswered = @questions.count - @answered
  end

  def new
    @answer = Answer.new
    @question = Question.find(params[:id])
    @choices = Choice.all
    respond_to do |format|
      format.js { render 'add.js.erb' }
      format.html
    end
  end

  def create
    if @answer.save
      save_answer
    else
      flash.now[:errors] = @answer.errors.full_messages
      @question = @answer.question
      add
    end
  end

  def edit
    @employee = Employee.find(current_employee.id)
    @answer_edit = Answer.find(params[:id])
    @choices = Choice.all
    respond_to do |format|
      format.js { render 'edit.js.erb' }
      format.html
    end
  end

  def update
    if @answer.update(update_params)
      @questions = Question.all
      refresh
    else
      flash.now[:errors] = @answer.errors.full_messages
      @answer_edit = @answer
      render_edit
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    answer_destroy
    refresh
  end

  def answer
    @employee = Employee.find(params[:id])
    @questions = Question.where(view_to_list: 1)
    @answers = Answer.all
    respond_to do |format|
      format.js { render 'answer.js.erb' }
      format.html
    end
  end

  def view_question_in_list
    @question = Question.find(params[:id])
    @answers = Answer.where(question_id: @question.id)
    respond_to do |format|
      format.js { render 'question.js.erb' }
      format.html
    end
  end

  def close
    @questions = Question.where(view_to_list: 1)
    respond_to do |format|
      format.js { render 'close.js.erb' }
      format.html
    end
  end

  def update_password
    if @employee_detail.update_with_password(user_params)
      bypass_sign_in(@employee_detail)
      flash[:success] = 'Password changed!'
      render js: "window.location='#{homepage_path(current_employee.id)}'"
    else
      flash.now[:errors] = @employee_detail.errors.full_messages
      render_password
    end
  end

  private

  def set_params
    params.require(:answer).permit(:answer, :question_id, :employee_id)
  end

  def update_params
    params.require(:answer).permit(:answer)
  end

  def user_params
    # NOTE: Using `strong_parameters` gem
    params.require(:employee).permit(:current_password, :password, :password_confirmation)
  end

  def fetch_index_data
    @q = Employee.ransack(params[:q])
    @employees = @q.result.order(name: :asc).page(params[:page]).per(15)
    @questions = Question.where(view_to_list: 1)
  end

  def fetch_create_data
    @answer = Answer.new(set_params)
    @employee = Employee.find(current_employee.id)
  end

  def fetch_update_data
    @answer = Answer.find(params[:id])
    @employee = Employee.find(current_employee.id)
  end

  def fetch_password_data
    @employee_detail = current_employee
  end

  def save_answer
    @employee = Employee.find(current_employee.id)
    @answers = Answer.where(employee_id: current_employee.id)
    @questions = Question.all
    @answered = @answers.count
    @unanswered = @questions.count - @answered
    flash.now[:success] = 'Answer Saved'
    refresh
  end

  def answer_destroy
    flash.now[:success] = 'Answer deleted successfully.'
    @employee = Employee.find(current_employee.id)
    @answers = Answer.where(employee_id: current_employee.id)
    @questions = Question.all
    @answered = @answers.count
    @unanswered = @questions.count - @answered
  end

  def refresh
    @answers = Answer.where(employee_id: current_employee.id)
    @answered = @answers.count
    @unanswered = @questions.count - @answered
    respond_to do |format|
      format.js { render 'fresh.js.erb' }
      format.html
    end
  end

  def add
    respond_to do |format|
      format.js { render 'add.js.erb' }
      format.html
    end
  end

  def render_edit
    respond_to do |format|
      format.js { render 'edit.js.erb' }
      format.html
    end
  end

  def render_password
    respond_to do |format|
      format.js { render 'password.js.erb' }
      format.html
    end
  end
end
# rubocop:enable Metrics/LineLength

# rubocop:enable Metrics/ClassLength
