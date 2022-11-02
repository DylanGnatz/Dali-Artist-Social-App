Feature: Chat with other users once a match has been made

  As an artist
  So that I can discuss possible collaborations
  I want to be able to chat with my matches

  Background: users in database
  Given the following users exist:
    | email             | username | password |
    | dali@gmail.com    | dali     |   123456 |
    | picasso@gmail.com | picasso  |   123456 |

  Given 'dali' is friends with 'picasso'

  Scenario: Land on chat page
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    Then I should successfully sign in
    And I follow "Chat"
    Then I should see "Chat"
    And I should see "Current Chats"

  Scenario: View my friends
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    Then I should successfully sign in
    When I follow "Chat"
    And I follow "New Chat"
    Then I should see "picasso"

