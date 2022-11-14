class Profile < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :chats, through: :chats_profiles
  has_many :friends
  has_many :artworks
  has_many :events

  def all_friends
    all = []
    Profile.find(id).friends.each do |obj|
      all.push(Profile.find(obj.friend_id))
    end
    Friend.where("friend_id = ?", id).each do |frndObj|
      all.push(frndObj.profile)
    end
    all
  end

end
