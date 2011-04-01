Given /^I am an existent User$/ do
  @user = User.create!(:name                  => "Renato Riccieri Santos Zannon",
                       :nickname              => "Bill",
                       :password              => "StrongPassword",
                       :password_confirmation => "StrongPassword")
end

When /^fill my credentials correctly$/ do
    pending # express the regexp above with the code you wish you had
end

Then /^I should be logged in$/ do
    pending # express the regexp above with the code you wish you had
end

