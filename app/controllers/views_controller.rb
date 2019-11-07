# frozen_string_literal: true

# Controller for question view in list
class ViewsController < ApplicationController
  before_action :admin
  before_action :fetch_create_data, only: [:create]

  def admin
    @employee = Employee.find(current_employee.id)
    authorize(@employee, :admin?)
  end

  def index
    @question_in_list = Question.where(view_to_list: 1)
    @question_not_in_list = Question.where(view_to_list: 0)
  end

  def create
    if @question.update(update_params)
    else
      flash.now[:errors] = @question.errors.full_messages
    end
    refresh
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end

  def update_params
    params.require(:question).permit(:view_to_list)
  end

  def refresh
    respond_to do |format|
      format.js { render 'fresh.js.erb' }
      format.html
    end
  end

  def fetch_create_data
    @question_in_list = Question.where(view_to_list: 1)
    @question_not_in_list = Question.where(view_to_list: 0)
    @question = Question.find(params[:id])
  end
end
