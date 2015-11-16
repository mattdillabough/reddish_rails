class CategoriesController < ApplicationController
  before_filter :get_current_user, only: :show

  def show
    @links = Link.where(category_id: params[:id])
    if @links.empty?
      @links = Link.all
    end
    @categories = Category.all
  end 
end