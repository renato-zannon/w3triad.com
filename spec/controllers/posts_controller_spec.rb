require 'spec_helper'

describe PostsController do

  before { mock_model('Post') }

  describe "GET index" do
    it "gets all the posts on the database" do
      Post.should_receive(:all)
      get :index
    end

    context "when there's at least one post" do
      before do
        @posts = [mock_model(Post)]
        Post.stub(:all).and_return @posts
      end

      it "passes the found posts as an instance variable" do
        get :index
        assigns[:posts].should == @posts
      end
    end

    context "when there are no posts" do
      before do
        Post.stub(:all).and_return []
      end

      it "sets an flash error message" do
        get :index
        flash[:error].should =~ /no posts/i
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
      new_post.should_receive(:save)
      post :create
    end

    context "when the post fails to save" do
      before do
        new_post.stub(:save).and_return false
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
end
