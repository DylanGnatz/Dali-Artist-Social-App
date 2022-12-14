Feature:
  As an artist with a Dali account
  So that I can make connections with other artists
  I want to swipe on other artist's accounts

  Background: users in database
    Given the following users exist:
      | email             | username | password |
      | dali@gmail.com    | dali     |   123456 |
      | picasso@gmail.com | picasso  |   123456 |
    And dali is in Madrid
    And picasso is in Madrid


  Scenario: Navigate to swipes page
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    And dali is in Madrid
    And picasso is in Madrid
    And I follow "Swipe"
    Then I should be on the swipes page

  Scenario: Option to swipe on other user
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    And I follow "Swipe"
    Then I should see "picasso"

  Scenario: Allow user to select interested or uninterested on other profiles.
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    And I follow "Swipe"
    Then I should see "Interested"
    And I should see "Not interested"

  Scenario: Exclude user's account from queue and notify when there are no more profiles
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    And I follow "Swipe"
    And I click the "Interested" button
    Then I should see "You've run out of profiles in your area!"
    And I should not see "dali"

  Scenario: Create match when two users select interested on each other
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    And I follow "Swipe"
    And I click the "Interested" button
    And I sign out
    And I log in with "picasso@gmail.com" and "123456"
    And I follow "Swipe"
    And I click the "Interested" button
    Then I should see "You just matched with 'dali'!"

  Scenario: Do not match when a user selects not interested
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    And I follow "Swipe"
    And I click the "Interested" button
    And I sign out
    And I log in with "picasso@gmail.com" and "123456"
    And I follow "Swipe"
    And I click the "Not interested" button
    Then I should not see "You just matched with 'dali'!"


