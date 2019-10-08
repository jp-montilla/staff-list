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
      # @question.save
      if @question.answer_type == 'Choice'
        respond_to do |format|
          format.js {render 'add.js.erb'}
          format.html
        end
      else
        redirect_to new_admin_question_path
      end
      # @question = Question.new(set_params)
      #   if @question.save
      #     @question_id = @question.id
      #     respond_to do |format|
      #       format.js {render 'add.js.erb'}
      #       format.html
      #     end
      #   else
      #   end
    end

    def create_choice
      binding.pry
      if Question.where(id: params[:q_id]) == []
        @question = Question.create(question: params[:q_question], answer_type: 'Choice')
        @choice = Choice.create(choice: params[:choice], question_id: @question.id)
        respond_to do |format|
          format.js {render 'add.js.erb'}
          format.html
        end
      end
      # @hey = Question.create(question: 'Tester for Question?', answer_type: 'Choice')
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







