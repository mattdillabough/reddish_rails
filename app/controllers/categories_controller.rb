class CategoriesController < ApplicationController
  before_filter :get_current_user, only: :show

  def show
    @links = Link.where(category_id: params[:id])
    if @links.empty?
      @links = Link.all
      session.delete(:category_id)
    else
      session[:category_id] = params[:id]
    end
    @categories = Category.all
  end 
end