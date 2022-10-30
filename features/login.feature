Feature: Registered Dali users can log in
  As an artist with a Dali account
  So that I can describe myself to other artists in my area
  I want a custom bio to appear on my public profile

  Background: users in database
    Given the following users exist:
      | email          | username | password |
      | dali@gmail.com | dali     |   123456 |

  Scenario: Land on login page
    When I go to the home page
    Then I should be on the log in page

  Scenario: User not logged in is redirected to log in page
    When I go to the friends page
    Then I should be on the log in page

  Scenario: Input existig credentials
    When I go to the home page
    And I log in with "dali@gmail.com" and "123456"
    Then I should successfully sign in

  Scenario: Input wrong email
    When I go to the home page
    And I log in with "picasso@gmail.com" and "123456"
    Then I should not successfully sign in

  Scenario: Input wrong password
    When I go to the home page
    And I log in with "dali@gmail.com" and "42"
    Then I should not successfully sign in

  Scenario: Redirected to the page the user tried to access before logging in
    When I go to the friends page
    And I log in with "dali@gmail.com" and "123456"
    Then I should be on the friends page

  Scenario: Log in page redirects logged in users to profile page
    When I go to the log in page
    And I log in with "dali@gmail.com" and "123456"
    Then I should be on the profile page
