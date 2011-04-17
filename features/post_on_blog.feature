Feature: Post on blog

    As an User
    I want to create a post on the blog
    So that I can be famous :)

    Background:
        Given I am logged in

    Scenario: New blog post
        Given I am on the posts page
        And I click on the "new post" link
        When I create a new post
        Then I should be able to see the post's complete page
        And I should be able to see it on the post's index

    Scenario Outline: Blog post formatting
        Given I am on the new post page
        When I fill in "Content" with "<raw_text>"
        And I fill in "Title" with "<title>"
        And I press "Save Post"
        Then I should be able to see "<formatted_text>"

        Examples: Default styles
            | title  |  raw_text  |           formatted_text               |
            | Test 1 |  #itext#i  | <span class='italic'>text</span>       |
            | Test 2 |  #btext#b  | <span class='bold'>text</span>         |
            | Test 3 |  #utext#u  | <span class='underline'>text</span>    |
            | Test 4 |  #otext#o  | <span class='overline'>text</span>     |
            | Test 5 |  #ttext#t  | <span class='line-through'>text</span> |

        Examples: User-defined styles
            | title  |      raw_text                |          formatted_text             |
            | Test 6 | #(span cool)text#(span)      | <span class='cool'>text</span>      |
            | Test 7 | #(span very_cool)text#(span) | <span class='very_cool'>text</span> |

        Examples: Comments
            | title  |      raw_text                  |          formatted_text             |
            | Test 8 |     \#ctext\#c                 |            #ctext#c                 |
            | Test 9 | \#(very cool)text\#(very cool) |    #(very cool)text#(very cool)     |

    Scenario: Blog post preview
        Given I am on the posts page
        And I click on the "new post" link
        When I write a new post
        And I press "preview"
        Then I should be able to see the post's complete page
        But I should no be able to see it on the post's index
