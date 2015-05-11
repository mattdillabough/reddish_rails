class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.create(user_params)
    if @user.valid?
      redirect_to root_path
    else
      render "new"
    end
  end
  
  def login
    if request.post?
      # Log the user in
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def login

  end
end