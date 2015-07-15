class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user||= User.find(session[:user_id]) if session[:user_id]
  end

  def ensure_user
    if !current_user
      session[:redirect_back] ||= request.fullpath
      flash[:error] = 'You must sign in'
      redirect_to sign_in_path
    end
  end

end
