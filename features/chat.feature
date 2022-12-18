Feature: Chat with other users once a match has been made

  As an artist
  So that I can discuss possible collaborations
  I want to be able to chat with my matches

  Background: users in database
  Given the following users exist:
    | email             | username | password |
    | dali@gmail.com    | dali     |   123456 |
    | picasso@gmail.com | picasso  |   123456 |
    | vinci@gmail.com   | vinci    |   123456 |

  Given the following users are friends:
    | user1    | user2   |
    | dali     | picasso |
    | dali     | vinci   |

  Scenario: Land on chat page
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    Then I should successfully sign in
    And I follow "Chat"
    Then I should see "Chats"

  Scenario: View my friends
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    Then I should successfully sign in
    When I follow "Chat"
    And I follow "New Chat"
    Then I should be on the friends page
    Then I should see "picasso"

  Scenario: Initiate a new chat
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    Then I should successfully sign in
    When I follow "Chat"
    Then I should not see "picasso"
    And I follow "New Chat"
    Then I should see "picasso"
    When I click the button with id "picasso"
    Then I should be on the chat show page
    When I fill in "chats_message_msg" with "Hi"
    And I click the "Send" button
    Then I should be on the chat show page
    Then I should see "Hi"

  Scenario: I should see the new chat in chats page
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    Then I should successfully sign in
    When I follow "Chat"
    And I follow "New Chat"
    When I click the button with id "picasso"
    Then I should be on the chat show page
    When I fill in "chats_message_msg" with "Hi"
    And I click the "Send" button
    Then I should see "Hi"
    When I go to the chats page
    Then I should see "picasso"

  Scenario: I should be able to resume a chat
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    Then I should successfully sign in
    When I follow "Chat"
    And I follow "New Chat"
    When I click the button with id "picasso"
    Then I should be on the chat show page
    When I fill in "chats_message_msg" with "Hi"
    And I click the "Send" button
    Then I should see "Hi"
    When I go to the chats page
    Then I should see "picasso"
    When I follow "picasso"
    Then I should be on the chat show page
    And I should see "Hi"
    When I fill in "chats_message_msg" with "you there bro?"
    And I click the "Send" button
    Then I should see "you there bro?"

  Scenario: I should be able to resume a chat through new chat
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    Then I should successfully sign in
    When I follow "Chat"
    And I follow "New Chat"
    When I click the button with id "picasso"
    Then I should be on the chat show page
    When I fill in "chats_message_msg" with "Hi"
    And I click the "Send" button
    Then I should see "Hi"
    When I go to the chats page
    And I follow "New Chat"
    When I click the button with id "picasso"
    Then I should be on the chat show page
    And I should see "Hi"
    When I fill in "chats_message_msg" with "you there bro?"
    And I click the "Send" button
    Then I should see "you there bro?"

  Scenario: The chat should work for both users
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    Then I should successfully sign in
    When I follow "Chat"
    And I follow "New Chat"
    When I click the button with id "picasso"
    Then I should be on the chat show page
    When I fill in "chats_message_msg" with "Hi"
    And I click the "Send" button
    Then I should see "Hi"
    Then I sign out
    Then I go to the home page
    And I log in with "picasso@gmail.com" and "123456"
    Then I should successfully sign in
    When I follow "Chat"
    Then I should see "dali"
    When I follow "dali"
    Then I should be on the chat show page
    And I should see "Hi"
    When I fill in "chats_message_msg" with "Yo Picasso suppp"
    And I click the "Send" button
    Then I should see "Yo Picasso suppp"

  Scenario: Sending an empty message should give an error
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    Then I should successfully sign in
    When I follow "Chat"
    And I follow "New Chat"
    When I click the button with id "picasso"
    Then I should be on the chat show page
    When I fill in "chats_message_msg" with ""
    And I click the "Send" button
    Then I should see "The message was empty!"

  Scenario: Delete a chat
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    Then I should successfully sign in
    When I follow "Chat"
    And I follow "New Chat"
    When I click the button with id "picasso"
    Then I should be on the chat show page
    When I fill in "chats_message_msg" with "Hi"
    And I click the "Send" button
    And I click the "Delete" button
    Then I should see "Chat was successfully deleted!"
