Feature: Users can add tags to their profiles to find others with similar interests

  As an artist
  So that I can indicate my interests and mediums
  I want tags that I select to appear on my public profile

  Background: user in database and logged in
    Given the following users exist:
      | email             | username | password |
      | picasso@gmail.com | picasso  |   123456 |
    And the "Painter" tag is available
    And I go to the home page
    And I log in with "picasso@gmail.com" and "123456"

  Scenario: Edit bio
    When I follow "Edit Profile"
    And I select "Painter" from tags
    And I click the "Add Tag" button
    Then I should see "Painter"
