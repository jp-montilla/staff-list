module Admin
  class QuestionsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Question.
    #     page(params[:page]).
    #     per(10)
    # end

    def create
      @question = Question.new(set_params)
      @valid = @question.question.match? /[a-zA-Z]/
      if @question.question != "" and @valid == true
        if Question.where(question: @question.question) == []
          if @question.answer_type == 'Choice'
            respond_to do |format|
              format.js {render 'add.js.erb'}
              format.html
            end
          else
            resource = resource_class.new(resource_params)
            authorize_resource(resource)
            if resource.save
              flash[:notice] = 'Question created successfully'
              render js: "window.location='#{admin_questions_path}'"
            end
          end
        else 
          flash[:error] = 'Question already existed!'
          render js: "window.location='#{new_admin_question_path}'"
        end
      else
        flash[:error] = 'Question cannot be blank!'
        render js: "window.location='#{new_admin_question_path}'"
      end
    end

    def create_choice
      if Question.where(id: params[:q_id]) == []
        @valid = params[:choice].match? /[a-zA-Z]/
        if @valid
          @question = Question.create(question: params[:q_question], answer_type: 'Choice')
          @choice = Choice.create(choice: params[:choice], question_id: @question.id)
        else
          flash.now[:error] = "Choice can't be blank."
          @question = Question.new(question: params[:q_question], answer_type: 'Choice')
        end
      else
        @valid = params[:choice].match? /[a-zA-Z]/
        if @valid
          @is_exist = Choice.where(question_id: params[:q_id], choice: params[:choice])
          if @is_exist == []
            @question = Question.find(params[:q_id])
            @choice = Choice.create(choice: params[:choice], question_id: params[:q_id])
          else
            @question = Question.find(params[:q_id])
            flash.now[:error] = "#{params[:choice]} already exist"
          end
        else
          @question = Question.find(params[:q_id])
          flash.now[:error] = "Choice can't be blank."
        end
      end
      respond_to do |format|
        format.js {render 'add.js.erb'}
        format.html
      end

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
        respond_to do |format|
          format.js {render 'add.js.erb'}
          format.html
        end
    end

    def check_question
      @question = Question.where(question: params[:question])
      if @question == []
        flash.now[:error] = 'Question must have at least 1 choice'
        @question = Question.new(question: params[:question], answer_type: 'Choice')
        respond_to do |format|
          format.js {render 'add.js.erb'}
          format.html
        end
      else
        flash.now[:notice] = 'Question created successfully'
        render js: "window.location='#{admin_questions_path}'"
      end
    end

    def delete_question
      @question = Question.find(params[:id])
      if @question.destroy
        flash[:notice] = 'Question creation cancelled'
        redirect_to admin_questions_path
      end
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
      

  end
end







