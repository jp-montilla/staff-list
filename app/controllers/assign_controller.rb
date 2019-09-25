class AssignController < ApplicationController
  before_action :admin

  def admin
    @employee = Employee.find(current_employee.id)
    authorize(@employee, :admin?)
  end

  def index
    @materials = Material.where(employee_id: nil)
    @employees = Employee.where(role: 'Employee')
  end

  def show
  end

  def new
    flash[:errors] = nil
    @employee = Employee.find(params[:id])
    @employee_box = params[:id]
    @materials = Material.where(employee_id: nil)
    respond_to do |format|
      format.js {render 'add.js.erb'}
      format.html
    end
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end


  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end

  private
    def set_params
      params.require(:choice).permit(:question_id, :choice)
    end

    def update_params
      params.require(:choice).permit(:choice)
    end
end
