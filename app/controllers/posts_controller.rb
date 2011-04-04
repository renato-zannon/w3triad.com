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
    return preview if params[:preview_button]
    @post        = escape Post.new(params[:post])
    @post.author = current_user
    @post.save!
    redirect_to @post, :notice => "The post was created successfully!"
  rescue Exception
    flash[:error] = "There was an error while trying to save the post!"
    render :new
  end

  def preview
    @post = escape Post.new(params[:post])
    render :preview
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
