# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength

# rubocop:disable Metrics/MethodLength

# rubocop:disable Metrics/LineLength

# rubocop:disable Metrics/AbcSize

# Choices Controller
class ChoicesController < ApplicationController
  before_action :admin
  before_action :fetch_create_data, only: [:create]
  before_action :fetch_destroy_data, only: [:destroy]

  def admin
    @employee = Employee.find(current_employee.id)
    authorize(@employee, :admin?)
  end

  def index
    @questions = Question.where(answer_type: 'Choice')
    @count = 0
  end

  def show; end

  def new
    @choice = Choice.new
    @question = Question.find(params[:id])
    @question_box = params[:id]
    add
  end

  def create
    if @is_choice_exist == []
      if @choice.save
        @questions = Question.where(answer_type: 'Choice')
        flash.now[:success] = 'Choice Saved'
        refresh
      else
        flash.now[:errors] = @choice.errors.full_messages
        @question = @choice.question
        @question_box = @question.id.to_s
        add
      end
    else
      flash.now[:error] = "#{@choice.choice} already exist."
      @question = @choice.question
      @question_box = @question.id.to_s
      add
    end
  end

  def edit
    @choice = Choice.find(params[:id])
    @question = @choice.question
    @question_box = @question.id.to_s
    render_edit
  end

  def update
    @choice = Choice.find(params[:id])
    @count = 0
    if @choice.update(update_params)
      @questions = Question.where(answer_type: 'Choice')
      flash.now[:success] = 'Choice Updated'
      refresh
    else
      flash.now[:errors] = @choice.errors.full_messages
      @question = @choice.question
      @question_box = @question.id.to_s
      render_edit
    end
  end

  def destroy
    if @choices > 1
      if @choice.destroy
        flash.now[:success] = 'Choice Deleted'
      else
        flash.now[:errors] = @choice.errors.full_messages
      end
    else
      flash.now[:error] = 'Cannot delete last choice.'
    end
    refresh
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end

  def set_params
    params.require(:choice).permit(:question_id, :choice)
  end

  def update_params
    params.require(:choice).permit(:choice)
  end

  def refresh
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

  def fetch_create_data
    @choice = Choice.new(set_params)
    @is_choice_exist = Choice.where(question_id: @choice.question_id, choice: @choice.choice)
    @count = 0
  end

  def fetch_destroy_data
    @choice = Choice.find(params[:id])
    @question = @choice.question
    @choices = @question.choice.count
    @question_num = params[:question_num].to_i
    @count = 0
    @questions = Question.where(answer_type: 'Choice')
  end
end
# rubocop:enable Metrics/ClassLength

# rubocop:enable Metrics/MethodLength

# rubocop:enable Metrics/LineLength

# rubocop:enable Metrics/AbcSize
