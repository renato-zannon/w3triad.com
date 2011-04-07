class PostsController < ApplicationController
  before_filter :require_login, :only => [:new, :create, :preview]

  caches_action :show
  #caches_action :index, :cache_path => index_cache_path #Rails only gets happy if this line is after the method...

  def index
    @posts = Post.paginate :all, :page => params[:page], :order => 'created_at DESC'
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
    expire_action :index
    redirect_to @post, :notice => "The post was created successfully!"
  rescue Exception
    flash.now[:error] = "There was an error while trying to save the post!"
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

  def require_login
    if current_user.nil?
      flash[:error] = "You must sign in to access that page"
      redirect_to posts_path
    end
  end

  def self.index_cache_path
    Proc.new do |c|
      { :page   => c.params[:page] || 1,
        :user   => current_user }
    end
  end

  caches_action :index, :cache_path => index_cache_path
end
