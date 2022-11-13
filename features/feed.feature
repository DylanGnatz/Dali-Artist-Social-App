Feature: Art feed

  As an artist using Dali,
  I want to see recent posts from my friends
  So I can keep up to date with my network

  Background: users in database and logged in
    Given the following users exist:
      | email                | username    | password |
      | dali@gmail.com       | dali        |   123456 |
      | picasso@gmail.com    | picasso     |   123456 |
      | monet@gmail.com      | monet       |   123456 |
    And I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    And "dali" is friend with "picasso"

  Scenario: Access feed page
    When I go to the home page
    And I follow "Feed"
    Then I should see "My Feed"
  
  Scenario: See friends' posts
    When "picasso" add artwork "Guernica"
    And I go to the home page
    And I follow "Feed"
    Then I should see "picasso added new artwork"
    And I should see "Guernica"
  
  Scenario: Do not see other posts
    When "monet" add artwork "Nymphea"
    And I go to the home page
    And I follow "Feed"
    Then I should not see "monet"