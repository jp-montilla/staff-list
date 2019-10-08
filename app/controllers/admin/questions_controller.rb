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
      if Question.where(question: @question.question) == []
        if @question.answer_type == 'Choice'
          respond_to do |format|
            format.js {render 'add.js.erb'}
            format.html
          end
        else
          redirect_to new_admin_question_path
        end
      else 
        flash[:error] = 'Question already existed!'
        binding.pry
        respond_to do |format|
          format.js {render 'fresh.js.erb'}
          format.html
        end
      end
    end

    def create_choice
      flash[:error] = ""
      if Question.where(id: params[:q_id]) == []
        if params[:choice] != ""
          @question = Question.create(question: params[:q_question], answer_type: 'Choice')
          @choice = Choice.create(choice: params[:choice], question_id: @question.id)
        else
          flash[:error] = "Choice can't be blank."
          @question = Question.new(question: params[:q_question], answer_type: 'Choice')
        end
      else
        if params[:choice] != ""
          @is_exist = Choice.where(question_id: params[:q_id], choice: params[:choice])
          if @is_exist == []
            @question = Question.find(params[:q_id])
            @choice = Choice.create(choice: params[:choice], question_id: params[:q_id])
          else
            @question = Question.find(params[:q_id])
            flash[:error] = "#{params[:choice]} already exist"
          end
        else
          @question = Question.find(params[:q_id])
          flash[:error] = "Choice can't be blank."
        end
      end
      respond_to do |format|
        format.js {render 'add.js.erb'}
        format.html
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







