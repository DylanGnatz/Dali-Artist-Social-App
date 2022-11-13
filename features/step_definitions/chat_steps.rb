# Given('{string} is friends with {string}') do |string, string2|
#     profile_id = Profile.find_by_username(string).id
#     friend_id = Profile.find_by_username(string2).id
#     Friend.create!({ profile_id: profile_id, friend_id: friend_id }) 
# end

Given /the following users are friends/ do |friends_table|
    Friend.delete_all
    friends_table.hashes.each do |friendship|
        profile_id = Profile.find_by_username(friendship[:user1]).id
        friend_id = Profile.find_by_username(friendship[:user2]).id
        Friend.create!({ profile_id: profile_id, friend_id: friend_id }) 
    end
end

Then /^I should be on the chat show page$/ do
    current_path = URI.parse(current_url).path
    current_path.should =~ /chats\/\d/
end

When /^I click the button with id "([^"]*)"$/ do |button|
    click_button(button)
end

When /^I go to the chats page$/ do
    visit "/chats"
end
