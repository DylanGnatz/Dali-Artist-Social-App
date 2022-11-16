Feature:
  As an artist with a Dali account
  So that I can make connections with other artists in my area
  I want to only see profiles near me

  Background: users in database
    Given the following users exist:
      | email             | username | password |
      | dali@gmail.com    | dali     |   123456 |
      | picasso@gmail.com | picasso  |   123456 |

  Scenario: Show profiles within 50 miles
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    And dali is in New York City
    And picasso is in New York City
    And I follow "Swipe"
    Then I should see "picasso"

  Scenario: Do not show any profiles if there are none within 50 miles
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    And dali is in Madrid
    And picasso is in New York City
    And I follow "Swipe"
    Then I should see "You've run out of profiles in your area!"
    And I should not see "dali"

