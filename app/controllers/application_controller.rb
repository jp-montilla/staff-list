class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit

  def pundit_user
    current_employee
  end

end


