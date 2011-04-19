class PostsController < ApplicationController
  before_filter :require_login, :only => [:new, :create, :preview]

  def index
    @posts = Post.paginate :all, :page => params[:page], :order => 'created_at DESC'
    if @posts.nil? || @posts.empty?
      flash[:notice] = I18n.t(:no_posts)
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
    expire_fragment(/\/posts\/(\?page=\d+)?/)
    redirect_to @post, :notice => I18n.t(:post_created)
  rescue Exception
    flash.now[:error] = I18n.t(:post_not_saved)
    render :new
  end

  def preview
    @post = escape Post.new(params[:post])
    render :preview
  end

  def show
    unless @post = Post.find(params[:id])
      flash[:error] = I18n.t(:post_not_found)
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
      flash[:error] = I18n.t(:unauthorized)
      redirect_to posts_path
    end
  end
end
