# frozen_string_literal: true

# Assigns Controller
class AssignsController < ApplicationController
  before_action :admin
  before_action :fetch_create_data, only: [:create]
  before_action :fetch_destroy_data, only: [:destroy]
  before_action :fetch_data, only: %i[index show]

  def admin
    @employee = Employee.find(current_employee.id)
    authorize(@employee, :admin?)
  end

  def index; end

  def show
    refresh
  end

  def new
    @employee = Employee.find(params[:id])
    @employee_box = params[:id]
    @materials = Material.where(employee_id: nil)
    add
  end

  # rubocop:disable Metrics/AbcSize
  def create
    if @material.update(update_params)
      @employee = Employee.find(params[:id])
      flash.now[:success] = "#{@material.name} assigned to #{@employee.email}!"
      refresh
    else
      flash.now[:errors] = @material.errors.full_messages
      add
    end
  end
  # rubocop:enable Metrics/AbcSize

  def destroy
    if @material.update(update_params)
      refresh
    else
      flash.now[:errors] = @choice.errors.full_messages
      add
    end
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end

  def update_params
    params.require(:material).permit(:employee_id)
  end

  def fetch_create_data
    @material = Material.find(params[:material_id])
    @employee = Employee.find(params[:employee])
    @employee_box = params[:employee]
    @materials = Material.where(employee_id: nil)
    @employees = Employee.all.order(name: :asc)
  end

  def refresh
    respond_to do |format|
      format.js { render 'fresh.js.erb' }
      format.html
    end
  end

  def add
    respond_to do |format|
      format.js { render 'add.js.erb' }
      format.html
    end
  end

  def fetch_destroy_data
    @material = Material.find(params[:id])
    @materials = Material.where(employee_id: nil)
    @employees = Employee.all.order(name: :asc)
  end

  def fetch_data
    @materials = Material.where(employee_id: nil)
    @employees = Employee.all.order(name: :asc)
  end
end
