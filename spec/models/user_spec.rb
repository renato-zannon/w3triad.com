require 'spec_helper.rb'

describe User do

  let(:user) { Factory(:user) }

  describe "validations" do
    it "is valid with valid attributes" do
      user.should be_valid
    end

    it "is invalid without a password" do
      user.password = ""
      user.should_not be_valid
    end

    it "is invalid without a password confirmation" do
      user.password_confirmation = ""
      user.should_not be_valid
    end

    it "is invalid with incompatible password and password_confirmation" do
      user.password              = "password"
      user.password_confirmation = "wrong password"
      user.should_not be_valid
    end

    it "is invalid without a name" do
      user.name = ""
      user.should_not be_valid
    end

    it "is invalid without an email" do
      user.email = ""
      user.should_not be_valid
    end

    it "is invalid with an invalid email" do
      user.email = "invalid email"
      user.should_not be_valid
    end
  end

  describe "#has_valid_password?" do
    let(:user) { Factory.create :user, :password       => "password",
                                :password_confirmation => "password"}

    it "returns true if the supplied password is the actual password of the user" do
      user.password = "password"
      user.should have_valid_password
    end

    it "returns false if the supplied password doesn't match the actual password" do
      user.password = "wrong password"
      user.should_not have_valid_password
    end
  end

end
