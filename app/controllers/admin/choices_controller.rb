module Admin
  class ChoicesController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Choice.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Choice.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

    def update
      @question_id = requested_resource.question_id
      @question = Question.find(@question_id)
      @choice = @question.choice.count
      if requested_resource.update(resource_params)
        if @choice == 1 and @question_id != requested_resource.question.id
          requested_resource.question_id = @question_id
          requested_resource.save
          flash.now[:error] = 'Cannot remove last choice'
          render :edit, locals: {
          page: Administrate::Page::Form.new(dashboard, requested_resource),
        }
        else
          redirect_to(
            [namespace, requested_resource],
            notice: translate_with_resource("update.success"),
          )
        end
      else
        render :edit, locals: {
          page: Administrate::Page::Form.new(dashboard, requested_resource),
        }
      end
    end
  end
end
