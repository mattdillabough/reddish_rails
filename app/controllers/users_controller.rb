class UsersController < ApplicationController
  RE_USERNAME = /\A[A-Za-z0-9_.]+\z/
  RE_EMAIL = /\A[A-Za-z0-9_.]+@[A-Za-z0-9_.]+\z/

  def new
    @user = User.new
  end
  
  def create
    @user = User.create(user_params)
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render "new"
    end
  end
  
  def login
    if request.post?
      # Log the user in
      user = User.find_by(email: user_params[:username])
      if !user
        user = User.find_by(username: user_params[:username])
      end
      user = user.try(:authenticate, user_params[:password])
      if !user
        @error = 'No user with that username or password found!'
        #request.remote_ip
        #memcache for login attempts
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