Feature:
  As an artist with a Dali account
  So that I can make connections with other artists
  I want to swipe on other artist's accounts

  Background: users in database
    Given the following users exist:
      | email             | username | password |
      | dali@gmail.com    | dali     |   123456 |
      | picasso@gmail.com | picasso  |   123456 |




  Scenario: Navigate to swipes page
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    And I follow "Swipe"
    Then I should be on the swipes page

  Scenario: Option to swipe on other user
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    And I follow "Swipe"
    Then I should see "picasso"

  Scenario: Exclude user's account from queue and notify when there are no more profiles
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    And I follow "Swipe"
    Then I should see "Interested"

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
    Then I should see "You've run out of profiles in your area!"
    And I should not see "dali"


