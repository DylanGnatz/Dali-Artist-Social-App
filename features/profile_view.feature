Feature: Expand profile view and showcase another users profile

As an artist using Dali,
I want to be able to expand user profile 
So I can see another artist’s portfolio and information

Background: I  see Picasso's page

Scenario: checking view profile for a user
  When I go to the view page for "Picasso"
  Then the bio should exist?
  Then the tag of "Picasso" should be "Painter" "Impressionist"
  Then the join date of "Picasso" should GET JOIN DATE 
  Then the artwork should exist?