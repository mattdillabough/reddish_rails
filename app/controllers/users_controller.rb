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
      user = User.find_by(username: user_params[:username])
      user = user.try(:authenticate, user_params[:password])
      if !user
        @error = 'No user with that username or password found!'
        return
      end
      session[:user_id] = user.id
      redirect_to :root
    end
    # Show the login page
  end
  
  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end