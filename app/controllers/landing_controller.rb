class LandingController < ApplicationController
  def index
    @employees = Employee.all
  end
end
