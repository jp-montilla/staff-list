class AssignsController < ApplicationController
  # before_action :
  before_action :admin

  def admin
    @employee = Employee.find(current_employee.id)
    authorize(@employee, :admin?)
  end

  def index
    @materials = Material.where(employee_id: nil)
    @employees = Employee.all.order(name: :asc)
  end

  def show
    @materials = Material.where(employee_id: nil)
    @employees = Employee.all.order(name: :asc)
    respond_to do |format|
        format.js {render 'reload.js.erb'}
        format.html
      end
  end

  def new
    @employee = Employee.find(params[:id])
    @employee_box = params[:id]
    @materials = Material.where(employee_id: nil)
    respond_to do |format|
      format.js {render 'add.js.erb'}
      format.html
    end
  end

  def create
    @material = Material.find(params[:material_id])
    @employee = Employee.find(params[:employee])
    @employee_box = params[:employee]
    @materials = Material.where(employee_id: nil)
    @employees = Employee.all.order(name: :asc)
    if @material.update(update_params)
      @employee = Employee.find(params[:id])
      flash.now[:success] = "#{@material.name} assigned to #{@employee.email}!"
      respond_to do |format|
        format.js {render 'fresh.js.erb'}
        format.html
      end
    else
      flash.now[:errors] = @material.errors.full_messages
      respond_to do |format|
        format.js {render 'add.js.erb'}
        format.html
      end
    end
  end

  def destroy
    @material = Material.find(params[:id])
    @materials = Material.where(employee_id: nil)
    @employees = Employee.all.order(name: :asc)
    if @material.update(update_params)
      respond_to do |format|
        format.js {render 'reload.js.erb'}
        format.html
      end
    else
      flash.now[:errors] = @choice.errors.full_messages
      respond_to do |format|
        format.js {render 'add.js.erb'}
        format.html
      end
    end
  end
  


  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end

  private
    def update_params
      params.require(:material).permit(:employee_id)
    end
end
