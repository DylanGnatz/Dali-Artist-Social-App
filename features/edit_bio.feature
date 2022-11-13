Feature: Users can add a short text bio to their profile to describe themselves

  As an artist
  So that I can describe myself to other artists in my area
  I want a custom bio to appear on my public profile

  Background: user in database and logged in
    Given the following users exist:
      | email             | username | password |
      | picasso@gmail.com | picasso  |   123456 |
    And I go to the home page
    And I log in with "picasso@gmail.com" and "123456"

  Scenario: Edit bio
    When I follow "Edit Profile"
    And I fill in "Bio" with "Hi, I am an artist"
    And I click the "Update Profile Info" button
    When I follow "View Public Profile"
    Then I should see "Hi, I am an artist"