require 'spec_helper.rb'

describe User do

  let(:user) { Factory(:user) }
  let(:new_user) { Factory.build(:user) }

  describe "validations" do
    it "is valid with valid attributes" do
      user.should be_valid
    end

    it "is invalid without a password" do
      user.password = ""
      user.should_not be_valid
    end

    it "a new user is invalid without a password confirmation" do
      new_user.password_confirmation = ""
      new_user.should_not be_valid
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

  describe ".authenticate" do
    it "returns the user, if a valid combination of password and email is provided" do
      new_user.password = 'password'
      new_user.password_confirmation = 'password'
      new_user.email = 'email@example.com'
      new_user.save

      User.authenticate(new_user.email, new_user.password).should == new_user
    end

    it "returns nil if a nonexistant email is passed" do
      User.authenticate("doesntexist@nowhere.com", user.password).should be_nil
    end

    it "returns nil if given a wrong password" do
      User.authenticate(user.email, "wrongpassword").should be_nil
    end

    it "returns nil if given both a wrong password and a nonexistant email" do
      User.authenticate("doesntexist@nowhere.com", "wrongpassword").should be_nil
    end
  end

  describe "setting a new password" do
    let(:user) { Factory.create :user, :password              => "password",
                                       :password_confirmation => "password" }
    it "works if the current password is set correctly" do
      user.password = "password"
      user.new_password = "newpassword"
      user.new_password_confirmation = "newpassword"
      user.should be_valid
    end

    it "doesn't work if the current password is incorrect" do
      user.password = "wrongpassword"
      user.new_password = "newpassword"
      user.new_password_confirmation = "newpassword"
      user.should_not be_valid
    end

    it "doesn't work if a password confirmation isn't supplied or is wrong" do
      user.password = "password"
      user.new_password = "newpassword"
      user.should_not be_valid

      user.new_password_confirmation = "wrongnewpassword"
      user.should_not be_valid
    end

    it "does nothing if new_password isn't supplied" do
      user.password = "password"
      user.should be_valid

      user.save
      user.password.should == "password"
    end
  end
end
