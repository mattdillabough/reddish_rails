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
      # Form accepts email in username field.
      user = User.find_by_email_or_username(user_params[:username])
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
  end
  
  def logout
    session.delete(:user_id)
    redirect_to :root
  end
  
  def request_reset
    # Empty controller action, no logic necessary.
  end

  def send_reset_email
    # Form accepts email in username field.
    @user = User.find_by_email_or_username(user_params[:username])
    @user.reset_token = ResetToken.generate()
    @user.save!
    UserMailer.reset_email(@user).deliver_later
    flash[:msg] = "If that user exists, a reset email has been sent."
    redirect_to request_reset_users_path
  end
  
  def begin_reset_password
    @reset_token_value = params[:reset_token]
    if @reset_token_value
      reset_token = ResetToken.find_by_value(@reset_token_value)
      if reset_token && reset_token.is_valid?
        @user = reset_token.user
      end
    end
  end
  
  def reset_password
    @reset_token_value = params[:user][:reset_token]
    reset_token = ResetToken.find_by_value(@reset_token_value)
    if reset_token.is_valid?
      @user = reset_token.user
      @user.password = params[:user][:password]
      @user.password_confirmation = params[:user][:password_confirmation]
      if @user.save
        redirect_to login_path
      else
        render :begin_reset_password
      end
    end
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