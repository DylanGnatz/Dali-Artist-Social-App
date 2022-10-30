Given /the following users exist/ do |users_table|
  User.delete_all
  users_table.hashes.each do |user|
    User.create user
  end
end

When /^I go to the log in page$/ do
  visit "/users/sign_in"
end

When /^I go to the registration page$/ do
  visit "/users/sign_up"
end

Then /^I should be on the log in page$/ do
  current_path = URI.parse(current_url).path
  current_path.should == "/users/sign_in"
end

Then /^I should be on the registration page$/ do
  current_path = URI.parse(current_url).path
  current_path.should == "/users/sign_up"
end

Then /^I should successfully sign in$/ do
  step %{I should see "Signed in successfully."}
end

Then /^I should successfully register$/ do
  step %{I should see "You have signed up successfully."}
end

Then /^I should not successfully sign in$/ do
  step %{I should see "Invalid Email or password."}
end

When /^I log in with "([^"]*)" and "([^"]*)"$/ do |mail, password|
  step %{I fill in "Email" with "#{mail}"}
  step %{I fill in "Password" with "#{password}"}
  click_button("Log in")
end

When /^I register with "([^"]*)", "([^"]*)", "([^"]*)" and "([^"]*)"$/ do |mail, username, password1, password2|
  step %{I fill in "Email" with "#{mail}"}
  step %{I fill in "Username" with "#{username}"}
  step %{I fill in "Password" with "#{password1}"}
  step %{I fill in "Confirm password" with "#{password2}"}
  click_button("Register")
end