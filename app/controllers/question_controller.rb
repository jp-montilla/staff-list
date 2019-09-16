class QuestionController < ApplicationController
  def new
    @question = Question.find(params[:id])
    @choices = Choice.all
    @answer = Answer.new
  end

  def create_answer_text
  end

  def create_answer_numerical
  end

  def create_answer_choice
    @answer = Answer.new(set_params)
    if @answer.save
      redirect_to users_path
    else
      flash[:errors] = @answer.errors.full_messages
      redirect_to users_new_path
    end
  end

  private
    def set_params
      params.require(:answer).permit(:answer, :question_id, :employee_id)
    end
end
