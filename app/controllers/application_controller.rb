class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user

  protected

  def configure_permitted_parameters
    added_attrs = [ :email, :name, :password, :password_confirmation, :icon, :profile, :level, :favorite_book, :twitter_link, :facebook_link, :instagram_link ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end

  def set_current_user
    User.current_user = current_user
  end
end

