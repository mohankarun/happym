class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :authenticate_user


  def authenticate_user
  if current_user.nil?
    flash[:error] = 'You must be signed in to view that page.'
    redirect_to :root
  end
  end

  def admin_previleges
  if current_user.role !='Admin'
    flash[:error] = 'No Permission'
    redirect_to :root
  end
  end

private

def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
end
end
