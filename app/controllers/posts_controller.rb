class PostsController < ApplicationController
  def index
    @posts = Post.all
    if @posts.nil? || @posts.empty?
      flash[:notice] = "No posts were found!"
    end
  end

  def new
    @post = Post.new(params[:post])
  end

  def create
    begin
      @post        = escape Post.new(params[:post])
      @post.author = current_user
      @post.save! unless params[:preview_button]
    rescue Exception
      flash[:error] = "There was an error while trying to save the post!"
    end

    if @post.nil? or @post.new_record?
      render :new
    else
      flash[:notice] = "The post was created successfully!"
      redirect_to @post
    end
  end

  def show
    unless @post = Post.find(params[:id])
      flash[:error] = "The requested post wasn't found!"
      redirect_to posts_path
    end
  end

  private
  def escape(post)
    post.content = CGI.escapeHTML(post.content)
    post.title   = CGI.escapeHTML(post.title)
    post
  end
end
