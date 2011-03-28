Given /^I click on the "([^"]*)" link$/ do |link_name|
  click_link link_name
end

When /^I create a new post$/ do
  When "I fill in \"Title\" with \"Stub post :)\""
  And  "I fill in \"Content\" with \"Stub content!\""
  And  "I press \"submit\""
end

Then /^I should be able to see it on the post's index$/ do
  visit posts_path
  page.body.should include "Stub post :)"
end

Then /^I should be able to see the post's complete page$/ do
  page.body.should include "Stub post :)"
  page.body.should include "Stub content!"
end
