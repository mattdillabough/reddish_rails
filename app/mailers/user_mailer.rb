class UserMailer < ApplicationMailer
  
  def welcome_email(user)
    @user = user
    @url  = 'http://reddish.0-z-0.com'
    mail(to: @user.email, subject: 'Welcome to Reddish')
  end
end
