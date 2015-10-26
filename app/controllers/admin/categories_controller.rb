class Admin::CategoriesController < AdminController
  before_action :redirect_if_not_logged_in, only: ['new', 'create']
  
  def index
    @categories = Category.all
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    @category.save
    if @category.valid?
      redirect_to root_path
    else
      render "new"
    end
  end
  
  private
  
  def category_params
    params.require(:category).permit(:name)
  end
  
  def redirect_if_not_logged_in
    if !get_current_user
      flash[:msg] = 'You must be logged in to create a catgory.'
      redirect_to url_for(controller: 'users', action: 'login')
    end
  end
end