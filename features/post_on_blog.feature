Feature: Post on blog

    As an User
    I want to create a post on the blog
    So that I can be famous :)

    Scenario: New blog post
        Given I am on the home page
        And I click on the "new post" link
        When I create a new post
        Then I should be able to see it on the post's index
        And I should be able to view it's complete page
