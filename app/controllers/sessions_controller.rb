class SessionsController < ApplicationController
  include ReCaptcha::AppHelper

  def new
  end

  def create
    unless validate_recap(params, ActiveModel::Errors.new(nil))
      flash.now[:error] = "The answer to the CAPTCHA was invalid, please try again"
      render :new and return
    end

    if user = User.authenticate(params[:nickname], params[:password])
      session[:user_id] = user.id
      flash[:notice] =  "Successfuly logged in as #{user.nickname}!"
      redirect_to posts_path
    else
      flash.now[:error] = "Nickname and password combination invalid. Please re-check the provided information"
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to posts_path, :notice => "Logged out!"
  end
end
