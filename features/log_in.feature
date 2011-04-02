Feature: User log in

    Scenario: Happy path login
        Given I am an existent User
        When I go to the admin login page
        And fill my credentials correctly
        Then I should be logged in

    Scenario: Providing wrong credentials
        Given I am an existent User
        When I go to the admin login page
        And I don't fill my credentials correctly
        Then I should not be logged in
