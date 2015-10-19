class MainController < ApplicationController
  
  before_filter :get_current_user, only: :index

  def index
    @links = Link.all
    @categories = Category.all
  end
  
  def show_category
    @links = Link.where(category_id: params[:id])
    @categories = Category.all
    render "index"
  end
end