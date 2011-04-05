Feature: User profiles

    Scenario: View user profile
      Given I am an existent User
      When I go to my profile's page
      Then I should be able to see my info

    Scenario: View "edit profile" page
      Given I am an existent User
      And I am logged in
      When I go to my profile's page
      And I press "Edit Profile"
      Then I should see a form to edit my profile
