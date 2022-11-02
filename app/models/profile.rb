class Profile < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :chats, through: :chats_profiles
  has_many :friends
  has_many :artwork

  def all_friends
    all = []
    Profile.find(id).friends.each do |obj|
      all.push(Profile.find(obj.friend_id))
    end
    # Friend.where("friend_id = ?", id).each do |frndObj|
    #   all.push(frndObj.profile)
    # end
    all
  end

  #how do i get a list of all the peices of art that a profile can have
  #  def all_artwork
  #    all_art = []
    #Profile.find(id).artwork.each do |obj|
    #  all_artwork.push(Profile.find(obj.art))
   # end
  #end

end
