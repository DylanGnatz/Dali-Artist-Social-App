Feature: Adding and deleting events

  As an artist
  So that I can connect with my network
  I want to be able to post events and delete them

  Background: users in database
    Given the following users exist:
      | email             | username | password |
      | dali@gmail.com    | dali     |   123456 |
    And I go to the home page
    And I log in with "dali@gmail.com" and "123456"

Scenario: Add event to account
  When I follow "Add Event"
  And  I fill in "Title" with "Brunch"
  And  I click the "Create Event" button
  Then I should be on the profile page

Scenario: Add event to account (fail)
  When I follow "Add Event"
  And  I fill in "Title" with ""
  And  I click the "Create Event" button
  Then I should see "New event"
  And I should see "Title is too short"

Scenario: Delete event from account
  Given "dali" add event "Brunch"
  When I follow "Edit Profile"
  Then I should see "Brunch"
  And  I click the "Delete" button
  Then I should see "Edit Profile"
  But I should not see "clocks"

