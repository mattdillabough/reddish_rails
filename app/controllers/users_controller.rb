class UsersController < ApplicationController
  RE_USERNAME = /\A[A-Za-z0-9_.]+\z/
  RE_EMAIL = /\A[A-Za-z0-9_.]+@[A-Za-z0-9_.]+\z/

  def new
    @user = User.new
  end
  
  def create
    @user = User.create(user_params)
    if @user.valid?
      UserMailer.welcome_email(@user).deliver_later
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render "new"
    end
  end
  
  def login
    if flash[:msg]
      @error = flash[:msg]
    end
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
      delayed_action(user)
      if session[:category_id]
        redirect_to category_path(session[:category_id])
        session.delete(:category_id)
     else
        redirect_to :root
     end
    end
    # Show the login page
  end
  
  def logout
    session.delete(:user_id)
    redirect_to :root
  end
  
  private
  
  def delayed_action(user)
    if session[:user_action]
      link = Link.find(session[:link_id])
      if session[:user_action] == 'upvote'
        link.upvote(user)
      elsif session[:user_action] == 'downvote'
        link.downvote(user)
      end
      session.delete(:user_action)
      session.delete(:link_id)
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end