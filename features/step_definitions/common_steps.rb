
When /^I go to the home page$/ do
  visit "/"
end

When /^I go to the friends page$/ do
  visit "/friends"
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

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^I follow "([^"]*)"$/ do |link|
  click_link(link)
end