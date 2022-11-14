When ('{string} add artwork {string}') do |username, title|
  profile = Profile.find_by_username(username)
  Artwork.create!({ title: title, profile_id: profile.id }) 
end

When ('{string} add event {string}') do |username, title|
  profile = Profile.find_by_username(username)
  Event.create!({ title: title, profile_id: profile.id }) 
end