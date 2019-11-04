# frozen_string_literal: true

module Admin
  # Choices Controller for administrate
  class ChoicesController < Admin::ApplicationController
    before_action :fetch_update_data, only: [:update]
    before_action :fetch_delete_data, only: [:delete]

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
      if requested_resource.update(resource_params)
        if (@choice == 1) && (@question_id != requested_resource.question.id)
          update_rollback
          redirect_edit
        else
          redirect_show_success
        end
      else
        redirect_edit
      end
    end

    def destroy
      if @choices > 1
        requested_resource.destroy
        flash[:notice] = translate_with_resource('destroy.success')
      else
        flash[:error] = 'Cannot remove last choice'
      end
      redirect_to admin_question_path(@question.id)
    end

    private

    def fetch_update_data
      @question_id = requested_resource.question_id
      @question = Question.find(@question_id)
      @choice = @question.choice.count
    end

    def update_rollback
      requested_resource.question_id = @question_id
      requested_resource.save
      flash.now[:error] = 'Cannot remove last choice'
    end

    def redirect_edit
      render :edit, locals: {
        page: Administrate::Page::Form.new(dashboard, requested_resource)
      }
    end

    def redirect_show_success
      redirect_to(
        [namespace, requested_resource],
        notice: translate_with_resource('update.success')
      )
    end

    def fetch_delete_data
      @choice = Choice.find(params[:id])
      @question = Question.find(@choice.question_id)
      @choices = @question.choice.count
    end
  end
end
