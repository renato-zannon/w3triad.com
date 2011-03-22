class PostsController < ApplicationController
  def index
    @posts = Post.all
    if @posts.nil? || @posts.empty?
      flash[:error] = "No posts where found!"
    end
  end

  def new
    @post = Post.new(params[:post])
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      flash[:notice] = "The post was created successfully!"
      redirect_to @post
    else
      flash[:error] = "There was an error while trying to save the post!"
      render :new
    end
  end

  def show
    unless @post = Post.find(params[:id])
      flash[:error] = "The requested post wasn't found!"
      redirect_to posts_path
    end
  end
end
