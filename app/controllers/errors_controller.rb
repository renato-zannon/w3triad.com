class ErrorsController < ActionController::Base
  def not_found
    flash[:error] = I18n.t(:page_not_found)
    redirect_to :action => :index, :controller => :posts
  end
end
