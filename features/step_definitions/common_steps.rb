

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

When /^I go to the home page$/ do
  visit "/"
end

When /^I go to the friends page$/ do
  visit "/friends"
end

Then /^I should be on the swipes page$/ do
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == "/swipes"
  else
    assert_equal "/swipes", current_path
  end
end

Then /^I should be on the friends page$/ do
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == "/friends"
  else
    assert_equal "/friends", current_path
  end
end
Then /^I should be on the profile page$/ do
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == "/profiles/index"
  else
    assert_equal "/profiles/index", current_path
  end
end

Then /^I should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then /^I should not see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
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