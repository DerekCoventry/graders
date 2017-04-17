class ApplicationController < ActionController::Base
  before_action	:configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception
  protected
  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up, keys: [:admin, :student, :professor, :fname, :lname])
  	devise_parameter_sanitizer.permit(:account_update, keys: [:admin, :student, :professor, :fname, :lname])
  end
end
