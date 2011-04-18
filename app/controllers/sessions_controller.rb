class SessionsController < ApplicationController
  include ReCaptcha::AppHelper

  def new
  end

  def create
    unless validate_recap(params, ActiveModel::Errors.new(nil))
      flash.now[:error] = I18n.t(:invalid_captcha)
      render :new and return
    end

    if user = User.authenticate(params[:nickname], params[:password])
      session[:user_id] = user.id
      flash[:notice] = I18n.t(:successful_login)
      redirect_to posts_path
    else
      flash.now[:error] = I18n.t(:invalid_login)
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to posts_path, :notice => I18n.t(:logged_out)
  end
end
