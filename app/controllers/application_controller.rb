class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  VERSION_SC = '0.5'

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: User::CRUD_ATTR)
  end
  
end
