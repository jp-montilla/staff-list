# frozen_string_literal: true

module Admin
  # Employees controller for administrate
  class EmployeesController < Admin::ApplicationController
    before_action :fetch_employee_count, only: %i[update destroy]
    before_action :fetch_employee, only: %i[update destroy]

    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Employee.
    #     page(params[:page]).
    #     per(10)
    # end
    #
    #

    def index
      @employee = Employee.new
      super
    end

    def create
      super
    end

    def edit
      @show_employee = Employee.find(params[:id])
      super
    end

    def update
      if params[:employee][:role] == 'Employee' && @count == 1 && @admin
        remove_admin
      elsif @employee.update(edit_params)
        update_employee
      else
        error_update_employee
      end
    end

    def destroy
      if (@employee.role == 'Admin') && (@count == 1)
        flash[:error] = 'Cannot delete last admin!'
        redirect_to admin_employees_path
      else
        super
      end
    end

    private

    def create_params
      params.require(:employee)
            .permit(:name, :email, :role, :password, :password_confirmation, :lat, :long)
    end

    def edit_params
      params.require(:employee).permit(:name, :email, :role, :profile_picture, :lat, :long)
    end

    def fetch_employee
      @employee = Employee.find(params[:id])
      @admin = true if @employee.role == 'Admin'
    end

    def fetch_employee_count
      @count = Employee.where(role: 'Admin').count
    end

    def remove_admin
      flash[:error] = 'Cannot remove last admin'
      redirect_to edit_admin_employee_path
    end

    def update_employee
      flash[:success] = 'Employee updated successfully!'
      redirect_to admin_employee_path
    end

    def error_update_employee
      flash[:error] = @employee.errors.full_messages.join('<br/>')
      redirect_to edit_admin_employee_path
    end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Employee.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
