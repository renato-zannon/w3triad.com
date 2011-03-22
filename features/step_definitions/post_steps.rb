Given /^I click on the "([^"]*)" link$/ do |link_name|
  click_link link_name
end

When /^I create a new post$/ do
  fill_in "Title", :with => "Stub post :)"
  fill_in "Content", :with => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  click_button :submit
end

Then /^I should be able to see it on the post's index$/ do
  visit posts_path
  page.body.should include "Stub post :)"
end

Then /^I should be able to see the post's complete page$/ do
  page.body.should include "Stub post :)"
  page.body.should include "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
end

