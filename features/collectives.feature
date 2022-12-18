Feature: Create collectives with my friends

  As an artist
  So that I can collaborate on art work

  Background: users in database
  Given the following users exist:
    | email             | username | password |
    | dali@gmail.com    | dali     |   123456 |
    | picasso@gmail.com | picasso  |   123456 |
    | vinci@gmail.com   | vinci    |   123456 |
    | astrix@gmail.com  | astrix   |   123456 |

  Given the following users are friends:
    | user1    | user2   |
    | dali     | picasso |
    | dali     | vinci   |
    | dali     | astrix  |

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
    When I fill in "collective_bio" with "Best boys out here!"
    When I select checkbox "picasso"
    When I select checkbox "vinci"
    And I click the "Create Collective" button
    Then I should be on the collectives page
    And I should see "GG Boys"

  Scenario: Create a new collective with an image
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    Then I should successfully sign in
    When I follow "Collectives"
    And I follow "New Collective"
    Then I should see "picasso"
    Then I should see "vinci"
    When I fill in "collective_name" with "GG Boys"
    When I fill in "collective_bio" with "Best boys out here!"
    When I select checkbox "picasso"
    When I select checkbox "vinci"
    And I attach "main_photo" with "features/upload-images/artist.jpg"
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
    When I fill in "collective_bio" with "Best boys out here!"
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
    When I fill in "collective_bio" with "Best boys out here!"
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

  Scenario: Shows an error when no collective name is given
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    Then I should successfully sign in
    When I follow "Collectives"
    And I follow "New Collective"
    When I select checkbox "picasso"
    When I select checkbox "vinci"
    And I click the "Create Collective" button
    Then I should see "The collective must have a name!"

  Scenario: Shows an error when no bio is mentioned
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    Then I should successfully sign in
    When I follow "Collectives"
    And I follow "New Collective"
    When I fill in "collective_name" with "GG Boys"
    And I click the "Create Collective" button
    Then I should see "The collective must have a bio!"

  Scenario: Shows an error when no members are selected
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    Then I should successfully sign in
    When I follow "Collectives"
    And I follow "New Collective"
    When I fill in "collective_name" with "GG Boys"
    When I fill in "collective_bio" with "Best boys out here!"
    And I click the "Create Collective" button
    Then I should see "The collective must have other members!"

  Scenario: Delete a collective
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    Then I should successfully sign in
    When I follow "Collectives"
    And I follow "New Collective"
    When I fill in "collective_name" with "GG Boys"
    When I fill in "collective_bio" with "Best boys out here!"
    When I select checkbox "picasso"
    When I select checkbox "vinci"
    And I click the "Create Collective" button
    Then I should be on the collectives page
    And I should see "GG Boys"
    When I follow "GG Boys"
    When I click the "Edit Collective" button
    When I click the "delete_collective" button
    Then I should see "Collective was successfully deleted!"
    And I should be on the collectives page

  Scenario: Edit a collective
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    Then I should successfully sign in
    When I follow "Collectives"
    And I follow "New Collective"
    When I fill in "collective_name" with "GG Boys"
    When I fill in "collective_bio" with "Best boys out here!"
    When I select checkbox "picasso"
    When I select checkbox "vinci"
    And I click the "Create Collective" button
    Then I should be on the collectives page
    And I should see "GG Boys"
    When I follow "GG Boys"
    When I click the "Edit Collective" button
    When I fill in "collective_name" with "NT Boys"
    When I fill in "collective_bio" with "Tried our best boys!"
    When I click the "Save changes" button
    Then I should see "Collective was successfully updated!"
    And I should be on the collectives page
    And I should see "NT Boys"

  Scenario: Add/Remove members from a collective
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    Then I should successfully sign in
    When I follow "Collectives"
    And I follow "New Collective"
    When I fill in "collective_name" with "GG Boys"
    When I fill in "collective_bio" with "Best boys out here!"
    When I select checkbox "picasso"
    When I select checkbox "vinci"
    And I click the "Create Collective" button
    And I should see "GG Boys"
    When I follow "GG Boys"
    When I click the "Edit Collective" button
    And I click the button with id "delete_vinci"
    Then I should see "Member was successfully removed"
    When I select checkbox "astrix"
    And I click the "Add" button
    Then I should see "Members were successfully added!"

  Scenario: Add artworks to collective
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    Then I should successfully sign in
    When I follow "Collectives"
    And I follow "New Collective"
    When I fill in "collective_name" with "GG Boys"
    When I fill in "collective_bio" with "Best boys out here!"
    When I select checkbox "picasso"
    When I select checkbox "vinci"
    And I click the "Create Collective" button
    And I should see "GG Boys"
    When I follow "GG Boys"
    And I click the "Add Artwork" button
    When I fill in "artwork_title" with "First art!"
    When I fill in "artwork_description" with "First artwork boys!"
    And I attach "art_image" with "features/upload-images/artist.jpg"
    And I click the "Add art!" button
    Then I should see "'First art!' was successfully added."

  Scenario: Delete an added artwork
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    Then I should successfully sign in
    When I follow "Collectives"
    And I follow "New Collective"
    When I fill in "collective_name" with "GG Boys"
    When I fill in "collective_bio" with "Best boys out here!"
    When I select checkbox "picasso"
    When I select checkbox "vinci"
    And I click the "Create Collective" button
    And I should see "GG Boys"
    When I follow "GG Boys"
    And I click the "Add Artwork" button
    When I fill in "artwork_title" with "First art!"
    When I fill in "artwork_description" with "First artwork boys!"
    And I attach "art_image" with "features/upload-images/artist.jpg"
    And I click the "Add art!" button
    Then I should see "'First art!' was successfully added."
    When I click the "Edit Collective" button
    Then I click the button with id "delete_First art!"
    Then I should see "Artwork was successfully deleted."
