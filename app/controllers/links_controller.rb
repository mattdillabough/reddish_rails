class LinksController < ApplicationController
  before_action :redirect_if_not_logged_in, only: ['new', 'create']
  
  def new
    @link = Link.new
  end
  
  def create
    # The 'create' method is essentially 'new and save if valid'
    @link = Link.new(link_params)
    @link.user = get_current_user 
    @link.save
    if @link.valid?
      redirect_to root_path
    else
      render "new"
    end
  end
  
  def upvote
    user = get_current_user
    if user
      link = Link.find(params[:id])
      render json: {success: link.upvote(user)}
    else
      render json: {show_login: true}
    end
  end
  
  private
  
  def redirect_if_not_logged_in
    if !get_current_user
      flash[:msg] = 'You must be logged in to create a link.'
      redirect_to url_for(controller: 'users', action: 'login')
    end
  end
  
  def link_params
    # {link: {url: 'http://foo.fake', title: 'Foo', 'dynamite': 'boom'}}
    params.require(:link).permit(:url, :title, :description, :category_id)
  end
end