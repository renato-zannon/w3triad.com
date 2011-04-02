class SessionsController < ApplicationController
  def new
  end

  def create
    if user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      flash[:notice] =  "Successfuly logged in as #{user.nickname}!"
      redirect_to posts_path
    else
      flash[:error] = "Nickname and password combination invalid. Please re-check the provided information"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to posts_path, :notice => "Logged out!"
  end
end
