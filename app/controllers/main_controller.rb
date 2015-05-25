class MainController < ApplicationController
  
  before_filter :get_current_user, only: :index

  def index
    @links = Link.all
  end
end