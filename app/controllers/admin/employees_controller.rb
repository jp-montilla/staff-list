module Admin
  class EmployeesController < Admin::ApplicationController
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

    
    def edit
      super
    end

    def update
      @employee = Employee.find(params[:id])
      if @employee.update(employee_params)
        flash.now[:success] = "Employee updated successfully!"
        redirect_to admin_employee_path
      else
        flash.now[:error] = @employee.errors.full_messages.join('<br/>')
        redirect_to edit_admin_employee_path
      end
    end

    def destroy
      @employee = Employee.find(params[:id])
      @count = Employee.where(role: 'Admin').count
      if @employee.role == 'Admin' and @count == 1
        flash.now[:error] = 'Cannot delete last admin!'
        redirect_to admin_employees_path
      else
        super
      end

    end


    private
      def employee_params
        params.require(:employee).permit(:name, :email, :profile_picture)
      end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Employee.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
