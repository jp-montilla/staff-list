class QuestionController < ApplicationController
  def new
    @question = Question.find(params[:id])
    @choices = Choice.all
    @answer = Answer.new
  end

  def create
    @answer = Answer.new(set_params)
    if @answer.save
      redirect_to homepage_path(current_employee.id)
    else
      flash[:errors] = @answer.errors.full_messages
      redirect_to homepage_path(current_employee.id)
    end
  end

  private
    def set_params
      params.require(:answer).permit(:answer, :question_id, :employee_id)
    end
end
