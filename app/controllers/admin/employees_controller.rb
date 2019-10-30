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

    def index
      @employee = Employee.new
      super
    end

    def create
      super
    end

    
    def edit
      super
    end

    def update
      @employee = Employee.find(params[:id])
      @count = Employee.where(role: 'Admin').count
      if params[:employee]["role"] == 'Employee' and @count == 1 and @employee.role == 'Admin'
        flash[:error] = "Cannot remove last admin"
        redirect_to edit_admin_employee_path
      else
        if @employee.update(edit_params)
          flash[:success] = "Employee updated successfully!"
          redirect_to admin_employee_path
        else
          flash[:error] = @employee.errors.full_messages.join('<br/>')
          redirect_to edit_admin_employee_path
        end
      end
    end

    def destroy
      @employee = Employee.find(params[:id])
      @count = Employee.where(role: 'Admin').count
      if @employee.role == 'Admin' and @count == 1
        flash[:error] = 'Cannot delete last admin!'
        redirect_to admin_employees_path
      else
        super
      end

    end


    private
      def create_params
        params.require(:employee).permit(:name, :email, :role, :password, :password_confirmation)
      end

      def edit_params
        params.require(:employee).permit(:name, :email, :role, :profile_picture)
      end


    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Employee.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
