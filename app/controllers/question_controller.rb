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

  def edit
    @answer = Answer.find(params[:id])
    @choices = Choice.all
  end

  def update
    @answer = Answer.find(params[:id])
    if @answer.update(update_params)
      flash[:success] = 'Answer updated successfully.'
      redirect_to homepage_path(current_employee.id)
    else
      flash[:errors] = @answer.errors.full_messages
      redirect_to homepage_path(current_employee.id)
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    if @answer.destroy
      flash[:success] = 'Answer deleted successfully.'
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
    def update_params
      params.require(:answer).permit(:answer)
    end
end
