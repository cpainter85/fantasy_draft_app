class AuthenticationController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'You have successfully signed in!'
      redirect_to session[:redirect_back] || root_path
    else
      flash[:error] = 'Invalid Email/Password combination'
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path, notice: 'You have successfully signed out!'
  end
end
