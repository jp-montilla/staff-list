class ChartController < ApplicationController
  before_action :admin

  def admin
      @employee = Employee.find(current_employee.id)
      authorize(@employee, :admin?)
  end

  def index
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end
end
