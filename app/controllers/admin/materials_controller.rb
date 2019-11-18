# frozen_string_literal: true

module Admin
  # Materials Controller for administrate
  class MaterialsController < Admin::ApplicationController
    before_action :create_params, only: [:create]
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
      if @material.save && @valid
        flash[:notice] = 'Material created successfully!'
        render js: "window.location='#{admin_materials_path}'"
      else
        flash.now[:error] = @material.errors.full_messages
        add_error
        render_add
      end
    end

    private

    def set_params
      params.require(:material).permit(:name, :material_type, :status, :serial_number)
    end

    def create_params
      @material = Material.new(set_params)
      if @material.material_type == 'License'
        @valid = @material.serial_number.match?(/\d{3}\-\d{3}\-\d{3}/)
      else
        @material.serial_number = nil
        @valid = true
      end
    end

    def add_error
      if @valid == false
        flash.now[:error].push("Invalid Format for Serial Number")
      end
    end

    def render_add
      respond_to do |format|
        format.js { render 'add.js.erb' }
        format.html
      end
    end
  end
end
