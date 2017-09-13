class ApplicationController < ActionController::Base
  before_action :configure_permitted_params, if: :devise_controller?

  def configure_permitted_params
    devise_parameter_sanitizer.for(:sign_up) {
      |u| u.permit(:email, :password, :password_confirmation, :name)
    }
  end

  protect_from_forgery with: :exception
end
