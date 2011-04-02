Given /^I am an existent User$/ do
  @user = User.create!(:name                  => "Renato Riccieri Santos Zannon",
                       :nickname              => "Bill",
                       :email                 => "renato.riccieri@gmail.com",
                       :password              => "StrongPassword",
                       :password_confirmation => "StrongPassword")
end

When /^fill my credentials correctly$/ do
  When "I fill in \"email\" with \"#{@user.email}\""
  When "I fill in \"password\" with \"#{@user.password}\""
  When "I press \"login\""
end

Then /^I should be logged in$/ do
  page.body.should include "Currently logged in as #{@user.nickname}"
end

When /^I don't fill my credentials correctly$/ do
  When "I fill in \"email\" with \"#{@user.email}\""
  When "I fill in \"password\" with \"wrongpassword\""
  When "I press \"login\""
end

Then /^I should not be logged in$/ do
  page.body.should_not include "Currently logged in as #{@user.nickname}"
  page.body.should include "invalid"
end

Given /^I am logged in$/ do
  Given "I am an existent User"
  When  "I go to the admin login page"
  When  "fill my credentials correctly"
end
