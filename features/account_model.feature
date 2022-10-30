Feature: Allow users to tag their interests and upload media

As a artist with an account,
I want to be able to add to my profile and tag for swiping
So I can showcase my art to other users and make my account stand out

Background: I have an account and want to edit my account

Scenario: adding tags and media to account
  When I go to the edit page for my account
  And I fill in "Media" with "TEXT FOR TEST"
  And I select "Painter" for Tags
  And I press "Update Profile Info"
  Then I should be on the view page
  And I should see "TEXT FOR TEST"
  And I should see Tags contains Painter