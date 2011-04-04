Feature: User profiles

    Scenario: View user profile
      Given I am an existent User
      When I go to my profile's page
      Then I should be able to see my info
