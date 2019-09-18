class ProfileController < ApplicationController
  def edit
    # @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])

    if @employee.update(set_params)
      flash[:success] = 'Password Updated Successfully'
      redirect_to homepage_path(current_employee.id)
    else
      flash[:errors] = @employee.errors.full_messages
      redirect_to edit_profile_path(current_employee.id)
    end
  end

  private
    def set_params
      params.require(:employee).permit(:old_password, :new_password, :password_confirmation)
    end
end
