class ChoicesController < ApplicationController
  before_action :admin

  def admin
      @employee = Employee.find(current_employee.id)
      authorize(@employee, :admin?)
  end

  def index
    @questions = Question.where(answer_type: 'Choice')
    @count = 0
  end

  def show
  end

  def new
    @choice = Choice.new
    @question = Question.find(params[:id])
    @question_box = params[:id]
    respond_to do |format|
      format.js {render 'add.js.erb'}
      format.html
    end
  end

  def create
    @choice = Choice.new(set_params)
    @is_choice_exist = Choice.where(question_id: @choice.question_id ,choice: @choice.choice) 
    if @is_choice_exist == []
      if @choice.save
        @questions = Question.where(answer_type: 'Choice')
        @count = 0
        flash.now[:success] = "Choice Saved"
        respond_to do |format|
          format.js {render 'fresh.js.erb'}
          format.html
        end
      else
        flash.now[:errors] = @choice.errors.full_messages
        @question = @choice.question
        @count = 0
        @question_box = @question.id.to_s
        respond_to do |format|
          format.js {render 'add.js.erb'}
          format.html
        end
      end
    else
      flash.now[:error] = "#{@choice.choice} already exist."
      @question = @choice.question
      @count = 0
      @question_box = @question.id.to_s
      respond_to do |format|
        format.js {render 'add.js.erb'}
        format.html
      end
    end   
  end

  def edit
    @choice = Choice.find(params[:id])
    @question = @choice.question
    @question_box = @question.id.to_s
    respond_to do |format|
      format.js {render 'edit.js.erb'}
      format.html
    end
  end

  def update
    @choice = Choice.find(params[:id])
    if @choice.update(update_params)
      @questions = Question.where(answer_type: 'Choice')
      @count = 0
      flash.now[:success] = "Choice Updated"
      respond_to do |format|
        format.js {render 'fresh.js.erb'}
        format.html
      end
    else
      flash.now[:errors] = @choice.errors.full_messages
      @question = @choice.question
      @question_box = @question.id.to_s
      @count = 0
      respond_to do |format|
        format.js {render 'edit.js.erb'}
        format.html
      end
    end
  end

  def destroy
    @choice = Choice.find(params[:id])
    @question = @choice.question
    @choices = @question.choice.count
    @question_num = params[:question_num].to_i
    if @choices > 1
      if @choice.destroy
        @questions = Question.where(answer_type: 'Choice')
        @count = 0
        flash.now[:success] = "Choice Deleted"
        respond_to do |format|
          format.js {render 'fresh.js.erb'}
          format.html
        end
      else
        flash.now[:errors] = @choice.errors.full_messages
        @questions = Question.where(answer_type: 'Choice')
        @count = 0
        respond_to do |format|
          format.js {render 'fresh.js.erb'}
          format.html
        end
      end
    else
      flash.now[:error] = 'Cannot delete last choice.'
      @questions = Question.where(answer_type: 'Choice')
      @count = 0
      respond_to do |format|
        format.js {render 'fresh.js.erb'}
        format.html
      end
    end
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end

  private
    def set_params
      params.require(:choice).permit(:question_id, :choice)
    end

    def update_params
      params.require(:choice).permit(:choice)
    end
end
