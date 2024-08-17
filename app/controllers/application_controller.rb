class ApplicationController < ActionController::Base
  # Desativa a proteção CSRF para solicitações JSON
  protect_from_forgery with: :null_session, if: -> { request.format.json? }

  # Configura parâmetros permitidos para Devise
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
