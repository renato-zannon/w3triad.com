require 'spec_helper'

describe SessionsController do

  describe "GET new" do
    it "is successful" do
      get :new
      response.should be_successful
    end
  end

  describe "POST create" do
    let(:user) { Factory(:user) }
    context "when the authentication is succesful" do
      before { User.stub(:authenticate).and_return user }

      it "sets the session variable user_id to the authenticated user's id" do
        post :create
        session[:user_id].should == user.id
      end

      it "sets a flash notice message to notificate the user" do
        post :create
        flash[:notice].should_not be_nil
      end
      it "redirects to the posts page" do
        post :create
        response.should redirect_to posts_path
      end
    end

    context "when the authentication fails" do
      before { User.stub(:authenticate).and_return nil }
      it "re-renders the 'login' page" do
        post :create
        response.should render_template :new
      end
    end
  end
end
