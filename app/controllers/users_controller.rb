class UsersController < ApplicationController
  def show
    begin
      @user = User.find_by_nickname(params[:nickname])
      raise if @user.nil?
    rescue Exception
      flash[:error] = "The user wasn't found"
      redirect_to posts_path
    end
  end

end
