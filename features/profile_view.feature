Feature: Expand profile view and showcase another users profile

  As an artist using Dali,
  I want to be able to expand user profile 
  So I can see the portfolio and information

  Background: users in database
  Given the following users exist:
    | email             | username | password |
    | dali@gmail.com    | dali     |   123456 |

  Scenario: Land on view page
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    Then I should successfully sign in
    When I follow "View Public Profile"
    Then I should see "dali"