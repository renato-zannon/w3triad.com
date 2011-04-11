require 'spec_helper'

describe UsersController do

  describe "GET 'show'" do
    let(:user) { Factory(:user) }

    context "if the provided nickname exists"  do
      before { User.stub(:find).and_return user }

      it "sets an instance variable containing the found user" do
        get 'show'
        assigns[:user].should == user
      end
    end


    context "if the user is not found" do
      before { User.stub(:find_by_nickname).and_return nil }

      it "sets a flash error message" do
        get 'show'
        flash[:error].should_not be_nil
      end

      it "redirects to the home page" do
        get 'show'
        response.should redirect_to posts_path
      end
    end
  end

end
