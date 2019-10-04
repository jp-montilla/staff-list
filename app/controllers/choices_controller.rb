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
    flash[:errors] = ""
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
    if @choice.save
      @questions = Question.where(answer_type: 'Choice')
      @count = 0
      flash[:success] = "Choice Saved"
      respond_to do |format|
        format.js {render 'fresh.js.erb'}
        format.html
      end
    else
      flash[:errors] = @choice.errors.full_messages
      @question = @choice.question
      @count = 0
      @question_box = @question.id.to_s
      respond_to do |format|
        format.js {render 'add.js.erb'}
        format.html
      end
    end
    flash[:success] = ""
  end

  def edit
    flash[:errors] = ""
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
      flash[:success] = "Choice Updated"
      respond_to do |format|
        format.js {render 'fresh.js.erb'}
        format.html
      end
    else
      flash[:errors] = @choice.errors.full_messages
      @question = @choice.question
      @question_box = @question.id.to_s
      @count = 0
      respond_to do |format|
        format.js {render 'edit.js.erb'}
        format.html
      end
    end
    flash[:success] = ""
  end

  def destroy
    @choice = Choice.find(params[:id])
    if @choice.destroy
      @questions = Question.where(answer_type: 'Choice')
      @count = 0
      flash[:success] = "Choice Deleted"
      respond_to do |format|
        format.js {render 'fresh.js.erb'}
        format.html
      end
    else
      flash[:errors] = @choice.errors.full_messages
      @questions = Question.where(answer_type: 'Choice')
      @count = 0
      respond_to do |format|
        format.js {render 'fresh.js.erb'}
        format.html
      end
    end
    flash[:success] = ""
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
