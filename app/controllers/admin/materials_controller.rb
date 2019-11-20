# frozen_string_literal: true

module Admin
  # Materials Controller for administrate
  class MaterialsController < Admin::ApplicationController
    # before_action :create_params, only: [:create]
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Material.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Material.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

    def index
      @material = Material.new
      super
    end

    def create
      @material = Material.new(set_params)
      if @material.save
        flash[:notice] = 'Material created successfully!'
        render js: "window.location='#{admin_materials_path}'"
      else
        flash.now[:error] = @material.errors.full_messages
        render_add
      end
    end

    private

    def set_params
      params.require(:material).permit(:name, :material_type, :status, :serial_number)
    end

    def render_add
      respond_to do |format|
        format.js { render 'add.js.erb' }
        format.html
      end
    end
  end
end
