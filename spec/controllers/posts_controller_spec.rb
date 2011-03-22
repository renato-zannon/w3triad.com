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
end
