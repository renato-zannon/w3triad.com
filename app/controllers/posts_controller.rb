class PostsController < ApplicationController
  def index
    posts = Post.all
    if posts.nil? || posts.empty?
      flash[:error] = "No posts where found!"
    else
      @posts = posts
    end
  end

  def new
    @post = Post.new(params[:post])
  end
end
