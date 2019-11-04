# frozen_string_literal: true

module Admin
  # Questions Controller for administrate
  class QuestionsController < Admin::ApplicationController # rubocop:disable Metrics/ClassLength
    before_action :set_create, only: [:create]
    before_action :valid, only: [:create_choice]
    before_action :fetch_check_question, only: [:check_question]
    before_action :set_params_choice, only: [:add_choice_valid]
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Question.
    #     page(params[:page]).
    #     per(10)
    # end

    def index
      @question = Question.new
      super
    end

    def create
      if (@question.question != '') && (@valid == true)
        if Question.where(question: @question.question) == []
          create_question
        else
          question_existed
        end
      else
        question_blank
      end
    end

    def create_choice
      if Question.where(id: params[:q_id]) == []
        add_first_choice
      else
        add_choice
      end
      render_add_choice
    end

    def remove_choice
      @choice = Choice.find(params[:id])
      @choices = Choice.where(question: params[:q_id]).count
      if @choices > 1
        @choice.destroy
      else
        flash.now[:error] = 'Cannot delete last choice!'
      end
      @question = Question.find(params[:q_id])
      render_add_choice
    end

    def check_question
      @que = params[:question]
      if @question == []
        flash.now[:error] = 'Question must have at least 1 choice'
        @question = Question.new(question: @que, answer_type: 'Choice')
        respond_to do |format|
          format.js { render 'add.js.erb' }
          format.html
        end
      else
        flash.now[:notice] = 'Question created successfully'
        render js: "window.location='#{admin_questions_path}'"
      end
    end

    def delete_question
      @question = Question.find(params[:id])
      @question.destroy
      flash[:notice] = 'Question creation cancelled'
      redirect_to admin_questions_path
    end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Question.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
    private

    def set_params
      params.require(:question).permit(:question, :answer_type)
    end

    def set_create
      @question = Question.new(set_params)
      @valid = @question.question.match?(/[a-zA-Z]/)
    end

    def create_question
      if @question.answer_type == 'Choice'
        question_with_choice
      else
        save_question
      end
    end

    def question_with_choice
      respond_to do |format|
        format.js { render 'add.js.erb' }
        format.html
      end
    end

    def save_question
      resource = resource_class.new(resource_params)
      authorize_resource(resource)
      flash[:notice] = 'Question created successfully'
      render js: "window.location='#{admin_questions_path}'"
    end

    def question_blank
      flash.now[:error] = 'Question cannot be blank!'
      respond_to do |format|
        format.js { render 'error.js.erb' }
        format.html
      end
    end

    def question_existed
      flash.now[:error] = 'Question already existed!'
      respond_to do |format|
        format.js { render 'error.js.erb' }
        format.html
      end
    end

    def valid
      @valid = params[:choice].match?(/[a-zA-Z]/)
    end

    def add_first_choice
      @que = params[:q_question]
      @cho = params[:choice]
      if @valid
        @question = Question.create(question: @que, answer_type: 'Choice')
        @choice = Choice.create(choice: @cho, question_id: @question.id)
      else
        flash.now[:error] = "Choice can't be blank."
        @question = Question.new(question: @que, answer_type: 'Choice')
      end
    end

    def add_choice
      if @valid
        add_choice_valid
      else
        @question = Question.find(params[:q_id])
        flash.now[:error] = "Choice can't be blank."
      end
    end

    def render_add_choice
      respond_to do |format|
        format.js { render 'add.js.erb' }
        format.html
      end
    end

    def add_choice_valid
      @is_exist = Choice.where(question_id: @que, choice: params[:choice])
      if @is_exist == []
        @question = Question.find(@que)
        @choice = Choice.create(choice: @choi, question_id: params[:q_id])
      else
        @question = Question.find(@que)
        flash.now[:error] = "#{@cho} already exist"
      end
    end

    def set_params_choice
      @que = params[:q_id]
      @cho = params[:choice]
    end

    def fetch_check_question
      @question = Question.where(question: params[:question])
    end
  end
end
