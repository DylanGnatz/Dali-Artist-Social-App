Feature: Users can create an account with an email and a password
  As an artist using Dali for the first time
  So that I can access the application
  I want to create a password protected user account

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

