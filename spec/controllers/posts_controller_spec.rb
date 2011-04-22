require 'spec_helper'

describe PostsController do

  before do
    mock_model('Post')
    PostsController.skip_before_filter :require_login
  end

  describe "GET index" do
    context "when there's at least one post" do
      before do
        @posts = [mock_model(Post)]
        Post.stub(:all).and_return @posts
      end

      it "passes the found posts as an instance variable" do
        get :index
        assigns[:posts].should_not be_nil
      end
    end

    context "when there are no posts" do
      before do
        Post.stub(:all).and_return []
      end

      it "sets an flash error message" do
        get :index
        flash[:notice].should =~ /no posts/i
      end
    end

  end

  describe "GET new" do
    it "creates a new post" do
      Post.should_receive(:new)
      get :new
    end

    it "sets the new post as an instance variable" do
      new_post = mock_model(Post)
      Post.stub(:new).and_return new_post
      get :new
      assigns[:post].should be new_post
    end
  end

  describe "POST create" do
    let(:new_post) { mock_model(Post).as_null_object }

    before do
      Post.stub(:new).and_return new_post
    end

    it "tries to save the post" do
      new_post.should_receive(:save!)
      post :create
    end

    context "when the post fails to save" do
      before do
        new_post.stub(:save!).and_raise ActiveRecord::RecordInvalid
        new_post.stub(:new_record?).and_return true
      end

      it "sets a flash error message" do
        post :create
        flash[:error].should =~ /error.*post/i
      end

      it "renders the 'new post' form" do
        post :create
        response.should render_template :new
      end
    end

    context "when the post is saved successfuly" do
      before do
        new_post.stub(:save).and_return true
      end

      it "sets a flash notice message" do
        post :create
        flash[:notice].should =~ /success/i
      end

      it "redirects to the post's page" do
        post :create
        response.should redirect_to new_post
      end
    end
  end

  describe "GET show" do
    it "searches for a post with the provided id" do
      Post.should_receive(:find).with 1
      get :show, :id => 1
    end

    context "when it doesn't find the post" do
      before do
        Post.stub(:find).and_raise ActiveRecord::RecordNotFound
      end

      it "sets a flash error message" do
        get :show, :id => 1
        flash[:error].should =~ /post.*found/i
      end

      it "redirects to the posts index page" do
        get :show, :id => 1
        response.should redirect_to posts_path
      end
    end

    context "when it finds the post" do
      let(:found_post) { mock_model(Post) }

      before do
        Post.stub(:find).and_return found_post
      end

      it "sets an instance variable containing the post" do
        get :show, :id => 1
        assigns[:post].should be found_post
      end
    end
  end

  describe "GET preview" do
    let(:incomplete_post) { Factory(:post) }

    it "sets an instance variable with a post based on the passed parameters" do
      params = { :title => incomplete_post.title, :content => incomplete_post.content }
      get :preview, :post => params
      assigns[:post].attributes.should have_value params[:title]
      assigns[:post].attributes.should have_value params[:content]
    end
  end

  describe "GET edit" do
    let(:postie) { Factory(:post) }
    let(:user) { postie.author }
    before { postie.author = user }
    context "if the requested post doesn't exist" do
      it "sets an error message" do
        get :edit, :id => postie.id+1
        flash[:error].should_not be_nil
      end

      it "redirects to the posts index" do
        get :edit, :id => postie.id+1
        response.should redirect_to posts_path
      end
    end

    context "if the current user is the author" do
      before { PostsController.stub(:current_user).and_return user }
      it "returns the post on an instance variable" do
        get :edit, :id => postie.id
        assigns[:post].should == postie
      end
    end
    context "if the current user isn't the author" do
      before { PostsController.stub(:current_user).and_return nil }
      it "sets an flash error message" do
        get :edit, :id => postie.id
        flash[:error].should_not be_nil
      end
      it "redirects to the post page" do
        get :edit, :id => postie.id
        response.should redirect_to post_path(postie)
      end
    end
  end
end
