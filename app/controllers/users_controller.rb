class UsersController < ApplicationController
  def new
    if current_user
      redirect_to users_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    # if !(User.where(email: user_params[:email]).empty?)
    #   redirect_to new_user_path
    #   flash[:notice] = "that email already exists silly"
    # else
      if @user.save
        session[:user_id] = @user.id
        redirect_to users_path
      else
        redirect_to new_user_path
        flash[:notice] = "Sorry that email already exists"
      end
    # end
  end

  def index
    @users = User.all
  end

  private 

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
