Given('{string} is friends with {string}') do |string, string2|
    profile_id = Profile.find_by_username(string).id
    friend_id = Profile.find_by_username(string2).id
    Friend.create!({ profile_id: profile_id, friend_id: friend_id }) 
end
