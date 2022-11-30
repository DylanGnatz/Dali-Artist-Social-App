Feature: Adding and deleting art

  As an artist
  So that I can display my work and build an online portfolio
  I want to be able to post my works of art onto my account and delete it

  Background: users in database
    Given the following users exist:
      | email             | username | password |
      | dali@gmail.com    | dali     |   123456 |
    And I go to the home page
    And I log in with "dali@gmail.com" and "123456"

Scenario: Add art to account
  When I click the "Add Artwork" button
  And  I fill in "Title" with "The Persistence of Memory"
  And  I fill in "Description" with "One of the most recognizable works of Surrealism"
  And  I fill in "Link" with "https://www.moma.org/collection/works/79018"
  And  I click the "Add art!" button
  Then I should be on the profile page

Scenario: Delete art from account
  Given "dali" add artwork "clocks"
  When I click the "Edit Profile" button
  Then I should see "clocks"
  And  I click the "Delete" button
  Then I should see "Edit Profile"
  But I should not see "clocks"

