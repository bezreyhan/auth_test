class AuthsController < ApplicationController
  def new
    if current_user
      redirect_to users_path
    else
      @user = User.new
    end
  end

  def create
    if !(User.where(email: params[:user][:email]).empty?)
      user = User.find_by(email: params[:user][:email])
      if user.authenticated? params[:user][:password]
        session[:user_id] = user.id
        redirect_to users_path
      else
        redirect_to new_auth_path
        flash[:notice] = "sorry the email or password did not match"
      end
    else
      redirect_to new_auth_path
      flash[:notice] = "sorry we couldn't find that email"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_auth_path
  end
end
