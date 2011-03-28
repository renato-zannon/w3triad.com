Feature: Post on blog

    As an User
    I want to create a post on the blog
    So that I can be famous :)

    Scenario: New blog post
        Given I am on the posts page
        And I click on the "new post" link
        When I create a new post
        Then I should be able to see the post's complete page
        And I should be able to see it on the post's index

    Scenario Outline: Blog post formatting
        Given I am on the new post page
        When I fill in "Content" with "<raw_text>"
        And I press "submit"
        Then I should see "<formatted_text>"

        Examples: Default styles
            |  raw_text  |        formatted_text               |
            |  $itext$i  | <span class='italic'>text</span>    |
            |  $btext$b  | <span class='bold'>text</span>      |
            |  $utext$u  | <span class='underline'>text</span> |
            |  $otext$o  | <span class='overline'>text</span>  |
