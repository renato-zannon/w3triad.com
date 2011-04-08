class UsersController < ApplicationController

  before_filter :check_user, :except => [:show]
  def show
    @user = User.find(:first, :conditions => ["lower(?) = lower(users.nickname)", params[:nickname]]) #Case-insensitive search
    raise if @user.nil?
  rescue Exception
    flash[:error] = "The user wasn't found"
    redirect_to posts_path
  end

  def edit_profile
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes!(params[:user])
    redirect_to :edit_profile, :notice => "Updated successfully!"
  rescue Exception
    flash.now[:error] = "The user couldn't be saved"
    render :edit_profile
  end

  private
  def check_user
    @user = User.find(params[:id])
    unless @user == current_user
      flash.now[:error] = "You have no permission to access that page"
      render :show, :status => :unauthorized
    end
  end
end
