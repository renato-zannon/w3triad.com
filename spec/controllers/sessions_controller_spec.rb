require 'spec_helper'

describe SessionsController do

  describe "GET new" do
    it "is successful" do
      get :new
      response.should be_successful
    end
  end
end
