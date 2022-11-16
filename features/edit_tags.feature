Feature: Users can add tags to their profiles to find others with similar interests

  As an artist
  So that I can indicate my interests and mediums
  I want tags that I select to appear on my public profile

  Background: user in database and logged in
    Given the following users exist:
      | email             | username | password |
      | picasso@gmail.com | picasso  |   123456 |
    And the "Painter" tag is available
    And the "Musician" tag is available
    And I go to the home page
    And I log in with "picasso@gmail.com" and "123456"

  Scenario: Add tag
    When I follow "Edit Profile"
    And I select "Painter" from tags
    And I click the "Add Tag" button
    Then I should see "Painter"

  Scenario: Display tag on profile
    When I follow "Edit Profile"
    And I select "Musician" from tags
    And I click the "Add Tag" button
    And I follow "Profile"
    And I follow "View Public Profile"
    Then I should see "Musician"
    And I should not see "Painter"

  Scenario: Remove tag from profile
    When I follow "Edit Profile"
    And I select "Painter" from tags
    And I click the "Add Tag" button
    And I select "Musician" from tags
    And I click the "Add Tag" button
    And I click to remove the "Painter" tag
    And I follow "Profile"
    And I follow "View Public Profile"
    Then I should see "Musician"
    And I should not see "Painter"


