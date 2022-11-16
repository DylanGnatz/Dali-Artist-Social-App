Feature: Create collectives with my friends

  As an artist
  So that I can collaborate on art work

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

  Scenario: Land on collectives page
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    Then I should successfully sign in
    And I follow "Collectives"
    Then I should see "Collectives"

  Scenario: Create a new collective
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    Then I should successfully sign in
    When I follow "Collectives"
    And I follow "New Collective"
    Then I should see "picasso"
    Then I should see "vinci"
    When I fill in "collective_name" with "GG Boys"
    When I select checkbox "picasso"
    When I select checkbox "vinci"
    And I click the "Create Collective" button
    Then I should be on the collectives page
    And I should see "GG Boys"

  Scenario: See members of a new collective
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    Then I should successfully sign in
    When I follow "Collectives"
    And I follow "New Collective"
    Then I should see "picasso"
    Then I should see "vinci"
    When I fill in "collective_name" with "GG Boys"
    When I select checkbox "picasso"
    When I select checkbox "vinci"
    And I click the "Create Collective" button
    Then I should be on the collectives page
    And I should see "GG Boys"
    When I follow "GG Boys"
    Then I should see "picasso"
    Then I should see "vinci"

Scenario: Chat in a collective Chat
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    Then I should successfully sign in
    When I follow "Collectives"
    And I follow "New Collective"
    Then I should see "picasso"
    Then I should see "vinci"
    When I fill in "collective_name" with "GG Boys"
    When I select checkbox "picasso"
    When I select checkbox "vinci"
    And I click the "Create Collective" button
    Then I should be on the collectives page
    And I should see "GG Boys"
    When I follow "GG Boys"
    Then I click the "collective_chat" button
    Then I should be on the chat show page
    When I fill in "chats_message_msg" with "Hi bois"
    And I click the "Send" button
    Then I should be on the chat show page
    Then I should see "Hi bois"
    Then I sign out
    Then I go to the home page
    And I log in with "picasso@gmail.com" and "123456"
    Then I should successfully sign in
    When I follow "Chat"
    Then I should see "GG Boys"
    When I follow "GG Boys"
    Then I should be on the chat show page
    And I should see "Hi bois"
    When I fill in "chats_message_msg" with "Hi homies"
    And I click the "Send" button
    Then I should be on the chat show page
    Then I should see "Hi homies"
    Then I sign out
    Then I go to the home page
    And I log in with "vinci@gmail.com" and "123456"
    Then I should successfully sign in
    When I follow "Chat"
    Then I should see "GG Boys"
    When I follow "GG Boys"
    Then I should be on the chat show page
    And I should see "Hi bois"
    And I should see "Hi homies"
