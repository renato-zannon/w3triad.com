Given /^I am an existent User$/ do
  @user = User.create!(:name                  => "Renato Riccieri Santos Zannon",
                       :nickname              => "Bill",
                       :email                 => "renato.riccieri@gmail.com",
                       :password              => "StrongPassword",
                       :password_confirmation => "StrongPassword")
end

When /^fill my credentials correctly$/ do
  When "I fill in \"Nickname\" with \"#{@user.nickname}\""
  When "I fill in \"password\" with \"#{@user.password}\""
  When "I press \"login\""
end

Then /^I should be logged in$/ do
  page.body.should include "Currently logged in as #{@user.nickname}"
end

When /^I don't fill my credentials correctly$/ do
  When "I fill in \"nickname\" with \"#{@user.nickname}\""
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

Then /^I should be able to see my info$/ do
  Then "I should see /Nickname.*Bill/"
  Then "I should see /Name.*Renato/"
  Then "I should see /Bio.*/"
  Then "I should see /E-mail.*renato\.riccieri@gmail.com/"
  Then "I should see /Latest posts/"
end

Then /^I should see a form to edit my profile$/ do
  page.should have_selector "form"
  ["Nickname", "Name", "Bio", "E-mail", "Current Password", "New Password", "New Password confirmation"].each do |field|
    page.should have_field field
  end
end
