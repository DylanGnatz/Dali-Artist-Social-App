
When /^I go to the home page$/ do
  visit "/"
end

When /^I go to the friends page$/ do
  visit "/friends"
end

Then /^I should be on the collectives page$/ do
  current_path = URI.parse(current_url).path
  current_path.should == "/collectives"
end

Then /^I should be on the swipes page$/ do
  current_path = URI.parse(current_url).path
  current_path.should == "/swipes"
end

Then /^I should be on the friends page$/ do
  current_path = URI.parse(current_url).path
  current_path.should == "/friends"
end
Then /^I should be on the profile page$/ do
  current_path = URI.parse(current_url).path
  current_path.should == "/profiles/index"
end

Then /^I should see "([^"]*)"$/ do |text|
  page.should have_content(text)
end

Then /^I should not see "([^"]*)"$/ do |text|
  expect(page).not_to have_content(text)
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end


When /^I follow "([^"]*)"$/ do |link|
  click_link(link)
end

When /^I click the "([^"]*)" button$/ do |button|
  click_button(button)
end

When /^I sign out$/ do
  visit(destroy_user_session_path)
end

When /^I select checkbox "(.*?)"$/ do |cb|
  check(cb)
end

And(/^I attach "(.*?)" with "(.*?)"$/) do |field, file|
  page.attach_file field, File.join(Rails.root, file)
end

