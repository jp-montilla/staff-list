# frozen_string_literal: true

class ViewsController < ApplicationController
  before_action :admin

  def admin
    @employee = Employee.find(current_employee.id)
    authorize(@employee, :admin?)
  end

  def index
    @question_in_list = Question.where(view_to_list: 1)
    @question_not_in_list = Question.where(view_to_list: 0)
  end

  def create
    @question_in_list = Question.where(view_to_list: 1)
    @question_not_in_list = Question.where(view_to_list: 0)
    @question = Question.find(params[:id])
    if @question.update(update_params)
      respond_to do |format|
        format.js { render 'fresh.js.erb' }
        format.html
      end
    else
      flash.now[:errors] = @question.errors.full_messages
      respond_to do |format|
        format.js { render 'fresh.js.erb' }
        format.html
      end
    end
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end

  private

  def update_params
    params.require(:question).permit(:view_to_list)
  end
end
