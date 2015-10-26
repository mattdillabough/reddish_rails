class AdminController < ApplicationController
  before_action :redirect_if_not_admin
  
  def index
    
  end
  
  private
  
  def redirect_if_not_admin
    if !get_current_user.admin?
      flash[:msg] = 'You must be an administrator to create a category.'
      redirect_to root_path
    end
  end
end