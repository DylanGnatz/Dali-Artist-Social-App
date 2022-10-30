Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create user
  end
end

When /^I go to the log in page$/ do
  visit "/users/sign_in"
end

Then /^I should successfully sign in$/ do
  step %{I should see "Signed in successfully."}
end

Then /^I should not successfully sign in$/ do
  step %{I should see "Invalid Email or password."}
end

When /^I log in with "([^"]*)" and "([^"]*)"$/ do |mail, password|
  step %{I fill in "Email" with "#{mail}"}
  step %{I fill in "Password" with "#{password}"}
  click_button("Log in")
end