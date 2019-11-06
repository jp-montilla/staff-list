# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_i18n_locale_from_params
  before_action :authenticate_employee!
  include Pundit

  def pundit_user
    current_employee
  end

  # rubocop:disable Metrics/AbcSize
  protected

  def set_i18n_locale_from_params
    # rubocop:disable Style/GuardClause

    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
    # rubocop:enable Style/GuardClause
  end
  # rubocop:enable Metrics/AbcSize
end
