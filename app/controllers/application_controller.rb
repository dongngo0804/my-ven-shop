class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :store_current_location, unless: :devise_controller?


  def logged_in?
    unless current_user
      flash[:notice] = 'Log in first'
      redirect_to new_user_session_path
    end
   end

  private

  # override the devise helper to store the current location so we can
  # redirect to it after loggin in or out. This override makes signing in
  # and signing up work automatically.
  def store_current_location
    store_location_for(:user, request.url)
  end

  # override the devise method for where to go after signing out because theirs
  # always goes to the root path. Because devise uses a session variable and
  # the session is destroyed on log out, we need to use request.referrer
  # root_path is there as a backup
  def after_sign_out_path_for(_resource)
    request.referrer || root_path
  end
  
end
