class LinksController < ApplicationController
  before_action :redirect_if_not_logged_in, only: ['new', 'create']
  
  def new
    @link = Link.new
  end
  
  def create
    # The 'create' method is essentially 'new and save if valid'
    @link = Link.create(link_params)
    if @link.valid?
      @link.user = get_current_user
      redirect_to root_path
    else
      render "new"
    end
  end
  
  private
  
  def redirect_if_not_logged_in
    if !get_current_user
      @error = 'You must be logged in to create a link.'
      redirect_to url_for(controller: 'users', action: 'login')
    end
  end
  
  def link_params
    # {link: {url: 'http://foo.fake', title: 'Foo', 'dynamite': 'boom'}}
    params.require(:link).permit(:url, :title, :description) # 4
  end
end