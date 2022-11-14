# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

password = '123456' # 123456

users = [
    { email:"shehan360@gmail.com", first_name: "Shehan", last_name: "Panditharatne", username: "shehan360" },
    { email:"tom@gmail.com", first_name: "Tom", last_name: "Son", username: "tomrocks" },
    { email:"ben@gmail.com", first_name: "Ben", last_name: "Ten", username: "benten" },
    { email:"seth@gmail.com", first_name: "Seth", last_name: "Donald", username: "seth10" },
    { email:"matt@gmail.com", first_name: "Matt", last_name: "Tolles", username: "matt20" },
    { email:"lev@gmail.com", first_name: "Lev", last_name: "Lescu", username: "lev" },
    { email:"sid@gmail.com", first_name: "Sid", last_name: "Cools", username: "SidCools" },
    { email:"mattered@gmail.com", first_name: "Matthew", last_name: "Red", username: "matteRED" },
]

tags = %w[Painter Sculptor Writer Journalist Poet Musician Photographer DJ Model Actor Performance\ Artist Drawing Collage Graphic /Design Multimedia /Artist Film Director Composer]

ChatsMessage.destroy_all
Chat.destroy_all
Friend.destroy_all
User.destroy_all
Profile.destroy_all

users.each do |user|
    # profile = Profile.create!({first_name: user[:first_name], last_name: user[:last_name], username: user[:username]})
    User.create!({email: user[:email], password: password, username: user[:username]})
end

tags.each do |tag|
  Tag.create!({tag_name: tag})
end
friends = [
    { :username => "shehan360", :friend => "tomrocks" },
    { :username => "shehan360", :friend => "benten" },
    { :username => "shehan360", :friend => "seth10" },
    { :username => "shehan360", :friend => "matt20" },
    { :username => "matteRED", :friend => "shehan360" },
]

friends.each do |fobj|
    profile_id = Profile.find_by_username(fobj[:username]).id
    friend_id = Profile.find_by_username(fobj[:friend]).id
    Friend.create!({ profile_id: profile_id, friend_id: friend_id })
end


chats = [
    { :username => "shehan360", :friend => "tomrocks", :messages => [{sender: 'shehan360', msg: 'Sup bro?'}, {sender: 'tomrocks', msg: 'good bro. u?'}] },
    { :username => "shehan360", :friend => "matt20",  :messages => [{sender: 'tomrocks', msg: 'sup?'}]},
]

chats.each do |chatObj|
    profile_id = Profile.find_by_username(chatObj[:username]).id
    friend_id = Profile.find_by_username(chatObj[:friend]).id
    chat = Chat.create!()
    ChatsProfile.create!(chat_id: chat.id, profile_id: profile_id)
    ChatsProfile.create!(chat_id: chat.id, profile_id: friend_id)
    chatObj[:messages].each do |chatMsg|
        sender_id = Profile.find_by_username(chatMsg[:sender]).id
        ChatsMessage.create!(chat_id: chat.id, profile_id: sender_id, msg: chatMsg[:msg])
    end
end