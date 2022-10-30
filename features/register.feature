Feature: Users can create an account with an email and a password
  As an artist using Dali for the first time
  So that I can access the application
  I want to create a password protected user account

  Background: users in database
    Given the following users exist:
      | email          | username | password |
      | dali@gmail.com | dali     |   123456 |

  Scenario: Registration from log in page
    When I go to the log in page
    And I follow "Register"
    Then I should be on the registration page

  Scenario: Successful registration
    When I go to the registration page
    And I register with "new@gmail.com", "new user", "123456" and "123456"
    Then I should successfully register

  Scenario: Unsuccesful registration (password too short)
    When I go to the registration page
    And I register with "new@gmail.com", "new user", "12345" and "12345"
    Then I should see "Password is too short"
  
  Scenario: Unsuccesful registration (username too short)
    When I go to the registration page
    And I register with "new@gmail.com", "", "123456" and "123456"
    Then I should see "Username is too short"
  
  Scenario: Unsuccesful registration (passwords don't match)
    When I go to the registration page
    And I register with "new@gmail.com", "new user", "123456" and "123457"
    Then I should see "Password confirmation doesn't match Password"

  Scenario: Unsuccesful registration (email already used)
    When I go to the registration page
    And I register with "dali@gmail.com", "new user", "123456" and "123456"
    Then I should see "Email has already been taken"

  