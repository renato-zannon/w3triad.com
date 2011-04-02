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
    pending # express the regexp above with the code you wish you had
end

