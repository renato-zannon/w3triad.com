class UsersController < ApplicationController

  before_filter :check_user, :except => [:show]
  def show
    @user = User.with_nickname(params[:nickname]) #Case-insensitive search
    raise if @user.nil?
  rescue Exception
    flash[:error] = I18n.t(:user_not_found)
    redirect_to posts_path
  end

  def edit_profile
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes!(params[:user])
    redirect_to :edit_profile, :notice => I18n.t(:user_updated)
  rescue Exception
    flash.now[:error] = I18n.t(:user_not_saved)
    render :edit_profile
  end

  private
  def check_user
    @user = User.find(params[:id])
    unless @user == current_user
      flash.now[:error] = I18n.t(:unauthorized)
      render :show, :status => :unauthorized
    end
  end
end
