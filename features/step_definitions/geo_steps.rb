When /^([^"]*) is in Madrid$/ do |username|
  profile = Profile.find_by_username(username)
  profile.update(lat: 40.416775, lng: -3.703790)
end

When /^([^"]*) is in New York City$/ do |username|
  profile = Profile.find_by_username(username)
  profile.update(lat: 40.7128, lng: 74.0060)
end
